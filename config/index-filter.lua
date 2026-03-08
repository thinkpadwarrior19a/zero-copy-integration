-- index-filter.lua — Pandoc Lua filter for automatic index generation
-- Scans text for key terms and inserts \index{} commands on first
-- occurrence per chapter.

local terms = {
  -- ZERO-COPY AND ARCHITECTURE
  { pattern = "zero%-copy integration",   index = "zero-copy integration" },
  { pattern = "zero%-copy",              index = "zero-copy integration" },
  { pattern = "data plane",              index = "data plane" },
  { pattern = "application integration plane", index = "application integration plane" },
  { pattern = "event plane",             index = "event plane" },
  { pattern = "control plane",           index = "control plane" },
  { pattern = "integration fabric",      index = "integration fabric" },
  { pattern = "data gravity",            index = "data gravity" },
  { pattern = "egress",                  index = "egress costs" },
  { pattern = "federation",              index = "data federation" },
  { pattern = "data virtualisation",     index = "data virtualisation" },
  { pattern = "federated query",         index = "federated query" },
  { pattern = "sovereign lakehouse",     index = "sovereign lakehouse" },
  { pattern = "Apache Iceberg",          index = "Apache Iceberg" },

  -- SOVEREIGNTY AND REGULATION
  { pattern = "sovereign zone",          index = "sovereign zone" },
  { pattern = "operational sovereignty", index = "operational sovereignty" },
  { pattern = "digital sovereignty",     index = "digital sovereignty" },
  { pattern = "data sovereignty",        index = "data sovereignty" },
  { pattern = "data residency",          index = "data residency" },
  { pattern = "data localisation",       index = "data localisation" },
  { pattern = "GDPR",                    index = "GDPR" },
  { pattern = "NIS ?2",                  index = "NIS 2 Directive" },
  { pattern = "DORA",                    index = "DORA (Digital Operational Resilience Act)" },
  { pattern = "EU AI Act",               index = "EU AI Act" },
  { pattern = "PIPL",                    index = "PIPL (China)" },
  { pattern = "DPDP",                    index = "DPDP Act (India)" },

  -- EVENTS AND MESSAGING
  { pattern = "event streaming",         index = "event streaming" },
  { pattern = "change data capture",     index = "change data capture (CDC)" },
  { pattern = "CDC",                     index = "change data capture (CDC)" },
  { pattern = "event mesh",              index = "event mesh" },
  { pattern = "Apache Kafka",            index = "Apache Kafka" },
  { pattern = "IBM MQ",                  index = "IBM MQ" },
  { pattern = "Event Streams",           index = "IBM Event Streams" },
  { pattern = "Outbox pattern",          index = "Outbox pattern" },

  -- API AND APPLICATION INTEGRATION
  { pattern = "API%-first",              index = "API-first design" },
  { pattern = "contract%-first",         index = "contract-first design" },
  { pattern = "API Connect",             index = "IBM API Connect" },
  { pattern = "DataPower",               index = "IBM DataPower" },
  { pattern = "App Connect",             index = "IBM App Connect Enterprise" },
  { pattern = "service mesh",            index = "service mesh" },
  { pattern = "API gateway",             index = "API gateway" },

  -- IBM PLATFORMS
  { pattern = "watsonx%.data",           index = "IBM watsonx.data" },
  { pattern = "watsonx",                 index = "watsonx" },
  { pattern = "Knowledge Catalog",       index = "IBM Knowledge Catalog" },
  { pattern = "Cloud Pak for Integration", index = "IBM Cloud Pak for Integration" },
  { pattern = "Instana",                 index = "IBM Instana" },
  { pattern = "Turbonomic",              index = "IBM Turbonomic" },
  { pattern = "Guardium",                index = "IBM Guardium" },
  { pattern = "Hyper Protect",           index = "IBM Hyper Protect" },
  { pattern = "QRadar",                  index = "IBM QRadar" },

  -- OPEN SOURCE AND INFRASTRUCTURE
  { pattern = "Red Hat OpenShift",       index = "Red Hat OpenShift" },
  { pattern = "OpenShift",               index = "Red Hat OpenShift" },
  { pattern = "Kubernetes",              index = "Kubernetes" },
  { pattern = "Terraform",               index = "HashiCorp Terraform" },
  { pattern = "HashiCorp Vault",         index = "HashiCorp Vault" },
  { pattern = "Open Policy Agent",       index = "Open Policy Agent (OPA)" },
  { pattern = "OPA",                     index = "Open Policy Agent (OPA)" },
  { pattern = "OpenTelemetry",           index = "OpenTelemetry" },
  { pattern = "OpenLineage",             index = "OpenLineage" },
  { pattern = "Apache Arrow",            index = "Apache Arrow" },
  { pattern = "Trino",                   index = "Trino" },
  { pattern = "IBM Cloud Satellite",     index = "IBM Cloud Satellite" },

  -- SECURITY
  { pattern = "Zero Trust",              index = "Zero Trust" },
  { pattern = "mutual TLS",             index = "mutual TLS (mTLS)" },
  { pattern = "confidential computing",  index = "confidential computing" },
  { pattern = "post%-quantum",           index = "post-quantum cryptography" },
  { pattern = "SPIFFE",                  index = "SPIFFE" },

  -- RESILIENCE AND OPERATIONS
  { pattern = "business continuity",     index = "business continuity" },
  { pattern = "disaster recovery",       index = "disaster recovery" },
  { pattern = "chaos engineering",       index = "chaos engineering" },
  { pattern = "active%-active",          index = "active-active configuration" },
  { pattern = "failover",                index = "failover" },
  { pattern = "idempoten",              index = "idempotency" },

  -- OPERATING MODEL
  { pattern = "maturity model",          index = "maturity model" },
  { pattern = "operating model",         index = "operating model" },
  { pattern = "platform team",           index = "platform team" },
  { pattern = "domain team",             index = "domain team" },
  { pattern = "chargeback",              index = "chargeback" },
  { pattern = "FinOps",                  index = "FinOps" },

  -- AI AND ANALYTICS
  { pattern = "RAG",                     index = "RAG (retrieval-augmented generation)" },
  { pattern = "large language model",    index = "large language model (LLM)" },
  { pattern = "LLM",                     index = "large language model (LLM)" },
  { pattern = "agentic AI",              index = "agentic AI" },
  { pattern = "federated learning",      index = "federated learning" },
}

local seen = {}
local current_chapter = ""

function Header(el)
  if el.level == 1 then
    current_chapter = pandoc.utils.stringify(el)
    seen = {}
  end
  return el
end

function Str(el)
  local text = el.text
  for _, term in ipairs(terms) do
    if text:find(term.pattern) then
      local key = term.index .. "|" .. current_chapter
      if not seen[key] then
        seen[key] = true
        return { el, pandoc.RawInline("latex", "\\index{" .. term.index .. "}") }
      end
    end
  end
  return el
end

function Para(el)
  local text = pandoc.utils.stringify(el)
  for _, term in ipairs(terms) do
    if text:find(term.pattern) then
      local key = term.index .. "|" .. current_chapter
      if not seen[key] then
        seen[key] = true
        table.insert(el.content, pandoc.RawInline("latex", "\\index{" .. term.index .. "}"))
      end
    end
  end
  return el
end
