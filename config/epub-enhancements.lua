-- epub-enhancements.lua — Pandoc Lua filter for ePub output
-- Generates a Table of Figures and a comprehensive Index as HTML sections

local figure_entries = {}
local index_terms = {}
local seen_terms = {}
local current_chapter = ""
local chapter_id = ""
local figure_counter = 0

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
    chapter_id = el.identifier or ""
    seen_terms = {}
  end
  return el
end

function Figure(el)
  local caption = pandoc.utils.stringify(el.caption)
  if caption and caption ~= "" then
    figure_counter = figure_counter + 1
    table.insert(figure_entries, {
      number = figure_counter,
      caption = caption,
      chapter = current_chapter
    })
  end
  return el
end

function Image(el)
  if el.caption and #el.caption > 0 then
    local caption = pandoc.utils.stringify(el.caption)
    if caption and caption ~= "" and caption ~= el.src then
      figure_counter = figure_counter + 1
      table.insert(figure_entries, {
        number = figure_counter,
        caption = caption,
        chapter = current_chapter
      })
    end
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
        local dominated = false
        for _, ch in ipairs(index_terms[term.index]) do
          if ch == current_chapter then dominated = true; break end
        end
        if not dominated then
          table.insert(index_terms[term.index], current_chapter)
        end
      end
    end
  end
  return el
end

function Pandoc(doc)
  local blocks = doc.blocks
  local new_blocks = {}

  -- Build Table of Figures
  local tof_html = '<section class="table-of-figures">\n<h1>Table of Figures</h1>\n<ol>\n'
  for _, fig in ipairs(figure_entries) do
    tof_html = tof_html .. string.format('<li><strong>Figure %d.</strong> %s</li>\n',
      fig.number, fig.caption)
  end
  tof_html = tof_html .. '</ol>\n</section>\n'

  -- Build Index
  local sorted_terms = {}
  for term, _ in pairs(index_terms) do
    table.insert(sorted_terms, term)
  end
  table.sort(sorted_terms, function(a, b) return a:lower() < b:lower() end)

  local index_html = '<section class="book-index">\n<h1>Index</h1>\n'
  local current_letter = ""
  for _, term in ipairs(sorted_terms) do
    local first = term:sub(1,1):upper()
    if first ~= current_letter then
      if current_letter ~= "" then
        index_html = index_html .. '</ul>\n'
      end
      current_letter = first
      index_html = index_html .. string.format('<h2>%s</h2>\n<ul>\n', current_letter)
    end
    local chapters = index_terms[term]
    local refs = table.concat(chapters, "; ")
    index_html = index_html .. string.format('<li><strong>%s</strong> &mdash; %s</li>\n', term, refs)
  end
  if current_letter ~= "" then
    index_html = index_html .. '</ul>\n'
  end
  index_html = index_html .. '</section>\n'

  -- Assemble
  for _, b in ipairs(blocks) do
    table.insert(new_blocks, b)
  end
  table.insert(new_blocks, pandoc.RawBlock("html", tof_html))
  table.insert(new_blocks, pandoc.RawBlock("html", index_html))

  doc.blocks = new_blocks
  return doc
end
