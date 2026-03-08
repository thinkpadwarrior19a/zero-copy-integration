-- docx-enhancements.lua — Pandoc Lua filter for DOCX output
-- Adds Table of Figures field and Index for Zero-Copy Integration

local index_terms = {}
local seen_terms = {}
local current_chapter = ""

local terms = {
  { pattern = "zero%-copy",              index = "zero-copy integration" },
  { pattern = "data plane",              index = "data plane" },
  { pattern = "application integration plane", index = "application integration plane" },
  { pattern = "event plane",             index = "event plane" },
  { pattern = "control plane",           index = "control plane" },
  { pattern = "integration fabric",      index = "integration fabric" },
  { pattern = "data gravity",            index = "data gravity" },
  { pattern = "sovereign zone",          index = "sovereign zone" },
  { pattern = "digital sovereignty",     index = "digital sovereignty" },
  { pattern = "data sovereignty",        index = "data sovereignty" },
  { pattern = "GDPR",                    index = "GDPR" },
  { pattern = "NIS ?2",                  index = "NIS 2 Directive" },
  { pattern = "DORA",                    index = "DORA (Digital Operational Resilience Act)" },
  { pattern = "EU AI Act",               index = "EU AI Act" },
  { pattern = "Apache Iceberg",          index = "Apache Iceberg" },
  { pattern = "Apache Kafka",            index = "Apache Kafka" },
  { pattern = "federated query",         index = "federated query" },
  { pattern = "API%-first",              index = "API-first design" },
  { pattern = "service mesh",            index = "service mesh" },
  { pattern = "watsonx",                 index = "watsonx" },
  { pattern = "Instana",                 index = "IBM Instana" },
  { pattern = "Kubernetes",              index = "Kubernetes" },
  { pattern = "Terraform",               index = "HashiCorp Terraform" },
  { pattern = "HashiCorp Vault",         index = "HashiCorp Vault" },
  { pattern = "OpenTelemetry",           index = "OpenTelemetry" },
  { pattern = "OpenLineage",             index = "OpenLineage" },
  { pattern = "Open Policy Agent",       index = "Open Policy Agent (OPA)" },
  { pattern = "Red Hat OpenShift",       index = "Red Hat OpenShift" },
  { pattern = "OpenShift",               index = "Red Hat OpenShift" },
  { pattern = "confidential computing",  index = "confidential computing" },
  { pattern = "Zero Trust",              index = "Zero Trust" },
  { pattern = "maturity model",          index = "maturity model" },
  { pattern = "operating model",         index = "operating model" },
  { pattern = "RAG",                     index = "RAG (retrieval-augmented generation)" },
  { pattern = "agentic AI",              index = "agentic AI" },
  { pattern = "chaos engineering",       index = "chaos engineering" },
  { pattern = "FinOps",                  index = "FinOps" },
}

function Header(el)
  if el.level == 1 then
    current_chapter = pandoc.utils.stringify(el)
    seen_terms = {}
  end
  return el
end

function Para(el)
  local text = pandoc.utils.stringify(el)
  for _, term in ipairs(terms) do
    if text:find(term.pattern) then
      local key = term.index .. "|" .. current_chapter
      if not seen_terms[key] then
        seen_terms[key] = true
        if not index_terms[term.index] then
          index_terms[term.index] = {}
        end
        table.insert(index_terms[term.index], current_chapter)
      end
    end
  end
  return el
end

function Pandoc(doc)
  local blocks = doc.blocks
  local new_blocks = {}

  -- Build Table of Figures section
  local tof_blocks = {}
  table.insert(tof_blocks, pandoc.Header(1, pandoc.Str("Table of Figures")))
  table.insert(tof_blocks, pandoc.Para({
    pandoc.Str("[Update this field in Word: select the text below, then press F9, or Insert > Index and Tables > Table of Figures]")
  }))
  table.insert(tof_blocks, pandoc.RawBlock("openxml",
    '<w:p><w:r><w:fldChar w:fldCharType="begin"/></w:r><w:r><w:instrText xml:space="preserve"> TOC \\c "Figure" </w:instrText></w:r><w:r><w:fldChar w:fldCharType="separate"/></w:r><w:r><w:t>Right-click and choose Update Field</w:t></w:r><w:r><w:fldChar w:fldCharType="end"/></w:r></w:p>'
  ))

  -- Build Index section
  local index_blocks = {}
  table.insert(index_blocks, pandoc.Header(1, pandoc.Str("Index")))

  local sorted_terms = {}
  for term, _ in pairs(index_terms) do
    table.insert(sorted_terms, term)
  end
  table.sort(sorted_terms, function(a, b) return a:lower() < b:lower() end)

  local current_letter = ""
  local items = {}
  for _, term in ipairs(sorted_terms) do
    local first = term:sub(1,1):upper()
    if first ~= current_letter then
      if #items > 0 then
        table.insert(index_blocks, pandoc.BulletList(items))
        items = {}
      end
      current_letter = first
      table.insert(index_blocks, pandoc.Header(2, pandoc.Str(current_letter)))
    end
    local chapters = index_terms[term]
    local chapter_list = table.concat(chapters, "; ")
    table.insert(items, {pandoc.Para({
      pandoc.Strong(pandoc.Str(term)),
      pandoc.Str(" — "),
      pandoc.Str(chapter_list)
    })})
  end
  if #items > 0 then
    table.insert(index_blocks, pandoc.BulletList(items))
  end

  -- Assemble
  for _, b in ipairs(blocks) do
    table.insert(new_blocks, b)
  end
  for _, b in ipairs(tof_blocks) do
    table.insert(new_blocks, b)
  end
  for _, b in ipairs(index_blocks) do
    table.insert(new_blocks, b)
  end

  doc.blocks = new_blocks
  return doc
end
