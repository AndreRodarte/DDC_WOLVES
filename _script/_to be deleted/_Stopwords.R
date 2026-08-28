## Stopwords & Domains

```{r}
# Stop-words: states, political parties, social-media vernacular, and procedural words (e.g. "celebrate")
# Municipalities from IBGE API
municipality_terms <- jsonlite::fromJSON(
  "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
)$nome %>%
  stringi::stri_trans_general(id = "Latin-ASCII") %>%
  stringr::str_to_lower() %>%
  stringr::str_trim() %>%
  unique()

# -------------------------
# Geographic terms
# -------------------------
# Includes Brazilian states, state abbreviations, demonyms, regional terms,
# and geographic hashtag variants identified during inspection.

geographic_terms <- c(
  "ac", "acre", "acreana", "acreano", "afederaldemt", "al", "alagoana", "alagoano", "alagoas", "am", "amapa", "amapaense", "amazona", "amazonas", "amazonense", "amorporroraima", "ap", "ba", "bahia", "baiana", "baiano", "baixadafluminense", "belemdopara", "belohorizonte", "boavista", "boraparaiba", "brasil", "brasiliense", "brasilur", "camposgerais", "camposs", "capital", "capitais", "capixaba", "catarina", "catarinense", "ce", "ceara", "cearense", "cearenses", "centro oeste", "centrooeste", "chuvasmg", "cidadaniapr", "compromissocomoparana", "df", "distrito federal", "distritofederal", "errejota", "es", "espirito santo", "espiritosanto", "estadodabahia", "estadodaparaiba", "estadodeacre", "estadodealagoas", "estadodegoias", "estadodemato grosso", "estadodematogrosso", "estadodematogrossodosul", "estadodemg", "estadodemina", "estadodeminas", "estadodeminasgerais", "estadodepernambuco", "estadoderondonia", "estadoderoraima", "estadoders", "estadodesantacatarina", "estadodesaopaulo", "estadodesc", "estadodesergipe", "estadodesp", "estadodetocantins", "estadodoacre", "estadodoamapa", "estadodoamazonas","estadodoceara", "estadododistritofederal", "estadodoespiritosanto", "estadodomaranhao", "estadodopara", "estadodoparana", "estadodopiaui", "estadodoriodejaneiro", "estadodoriograndedosul", "estadodorn", "federalrj", "fluminense", "frentepopulardorecife", "frentepopulardepernambuco", "gaucha", "gaucho", "go", "goia", "goiana", "goiano", "goias", "governodabahia", "governodoceara", "governorj", "grosso", "ibiritimig", "ibiritemg", "iguacu", "interiorsp", "ma", "manauscity", "marajo", "maranhao", "maranhense", "maranhenses", "maranhaozinho", "matogrosso", "matogrossodosul", "mato grosso", "mato grosso do sul", "mg", "miguelcoelhope", "minas", "minas gerais", "minasgerais", "minasgeral", "mineira", "mineiro", "ms", "mt", "mudapiaui", "nordeste", "nordestina", "nordestino", "norte", "novaiguacu", "pa", "para", "paraense", "paraiba", "paraibana", "paraibano", "parana", "paranaense", "paulista", "pb", "pe", "pelabahia", "pelomaranhao", "peloparana", "peloparano", "pelopiaui", "pernambuco", "pernambucana", "pernambucano", "pernambucoemfoco", "pi", "piaui", "piauiense", "pontagrossa", "porminas", "porsergipe", "potiguar", "pr", "prafrentesp", "psbma", "psolpa", "ptbahia", "rj", "rio", "rio de janeiro", "rio grande do norte", "rio grande do sul", "riodejaneiro", "riograndedonorte", "riograndedosul", "rn", "ro", "rondonia", "rondoniense", "roraima", "roraimense", "rr", "rs", "santa catarina", "santacatarina", "santacatarino", "sao paulo", "saopaulo", "spaulo", "saudegoias", "saudemg", "sc", "se", "sergipe", "sergipana", "sergipano", "sp", "sudeste", "sudoeste", "sudoestegoiano", "sul", "sulmatogrossense", "sulmatogrossenses", "tocantins", "tocantinense", "to", "todosporminas", "trabalhandoporgoias", "trabalhandoporpernambuco", "trabalhandoporsergipe", "trabalhandoporsp", "trabalhopelaparaiba", "votuporangasp", "riobonito", "saogoncalo", "bancadacapixaba", "saopedrodaaldeia", "riodasostras", "arraialdocabo", "duasbarras", "camposdosgoytacazes")

# -------------------------
# Party and partisan labels
# -------------------------

party_terms <- c(
  "avante", "avante70", "cidadania", "cidadania23", "cidadaniapr", "contecomonovo", "convencaorepublicanos", "dem", "democrata", "democratas", "juntospodemos", "juntospodemosmais", "juntospodemosmal", "mdb", "mulheresrepublicanas", "novo", "novo30", "novodeverdade", "novonacamara", "partido", "partidoliberal", "partidonovo", "partidonovo30", "partidos", "patriota", "patriotape", "patriotarj", "pcb", "pcdob", "pco", "pdt", "phs", "pl22", "plsp", "pmdb", "pmn", "podemos", "pp", "pps", "pr", "prb", "progressista", "progressistas", "progressistassp", "prp", "prtb", "psb", "psb40", "psbma", "psc", "psc20", "pscnacional20", "psd", "psdb", "psdc", "psdnacamara", "psl", "psl17", "pslbrasil", "pslnacamara", "pslraiz", "psol", "psolpa", "pstu", "pt", "ptbahia", "ptb", "ptc", "ptdob", "ptn", "pv", "republicano", "republicanos", "republicanos10", "republicanosnacamara", "republicanosrs", "republicanoss", "solidariedade", "solidariedadecer", "soumdb", "uniaobrasil", "vote19"
)

# -------------------------
# Platform and social media vernacular
# -------------------------

social_media_vernacular_terms <- c(
  "ao vivo", "aovivo", "boanoite", "boasemana", "boatarde", "bomdia", "comente",
  "comentem", "compartilhar", "compartilhe", "compartilhem", "confira", "curta",
  "curtir", "descricao", "detalhe", "dizer", "direct", "email", "foryou", "foryoupage", "foto", "fyp", "getrepost", "hashtag", "hein", "inscreva", "instaphoto", "leia", "link", "namidia", "page", "paratodosverem", "pracegover", "pracegorver", "pratodosverem", "published", "repost", "segue", "seguem", "seguindo", "sextou", "siga", "sigame", "sugestao", "tamo", "tamojunto", "tbt", "tbtdehoje", "text", "timeline", "vamo", "vamo que vamo", "vamoquevamo", "vamos", "viral", "viralvideo", "viralvideos", "video"
)

# -------------------------
# Political titles, offices, and generic mandate terms
# -------------------------

political_title_terms <- c(
  "amudancajacomecou", "boratrabalhar", "camara", "camaradosdeputados", "dep", "depfederal", "deputada", "deputadafederal", "deputado", "deputadofederal", "deputadosdem", "equipe", "federal", "federals", "gabinete", "semprepresente", "praseguiremfrente", "trabalhoquedaresultado", "mandatoderesultados", "politico", "politicos", "pracimadeles", "quemvotounaosearrepende", "senador", "trabalho", "vamosemfrente", "eleicao2022", "eleição2022", "eleicoes2022", "eleições2022")

# -------------------------
# Time-related terms
# -------------------------
# Includes months, weekdays, retrospective labels, and generic temporal markers.

time_terms <- c(
  "abril", "agosto", "anos", "atras", "atual", "calendario", "ciclo", "dezembro", "domingo", "fevereiro", "fimdesemana", "janeiro", "julho", "junho", "maio", "marco", "novembro", "outubro", "quarta", "quinta", "resumo da semana", "resumodasemana", "resumodasemano", "restrospectiva2020", "retrospectiva", "retrospectiva2018", "retrospectiva2019", "retrospectiva2020", "retrospectiva2021", "sabado", "segunda", "serie", "setembro", "sexta", "terca", "felizdiadospais", "felizdiadasmaes"
)

# -------------------------
# Celebration, greetings, and affective terms
# -------------------------

celebration_terms <- c(
  "abraco", "afetuoso", "agradeco", "amar", "celebrar", "comemoramos", "companheiro", "conforto", "excelente", "felicitacao", "felicidade", "felicidades", "fraterno", "linda", "lindo", "otimo", "parabens", "recebam", "satisfacao", "saudar", "valeu")

# -------------------------
# Generic high-frequency or low-substantive terms
# -------------------------

generic_stop_words <- c(
  "acelerar", "achar", "artigo", "assuntos", "busco", "cadastro", "cara", "cobrar", "colocamos", "comigo", "correr", "cumpro", "deixe", "detalhe", "dificil", "entao", "escritorio", "espero", "essencial", "estado", "existir", "fiquem", "fique", "foco", "gostaria", "ideal", "imenso", "individual", "iniciar", "intenso", "longo", "misturar", "parar", "peco", "pedir", "pensar", "pessoal", "podemos", "positivo", "precisamos", "profundo", "prol", "pude", "ramal", "referente", "seguimos", "sensacao", "terminamos", "todo", "unidade", "usar", "vago", "visar")


# -------------------------
# Combined custom stopwords
# -------------------------
custom_stopwords <- c(
  quanteda::stopwords("pt"),
  quanteda::stopwords("en"),
  municipality_terms,
  geographic_terms,
  party_terms,
  social_media_vernacular_terms,
  political_title_terms,
  time_terms,
  celebration_terms,
  generic_stop_words
) %>%
  stringi::stri_trans_general(id = "Latin-ASCII") %>%
  stringr::str_to_lower() %>%
  stringr::str_trim() %>%
  unique()


# -------------------------
# Account-specific self terms
# -------------------------
generic_profile_terms <- c(
  "oficial", "deputado", "deputada", "dep", "federal", "senador", "senadora", "vereador", "vereadora", "dr", "dra", "professor", "professora", "psl", "pl", "pt", "psdb", "mdb", "novo", "psol", "brasil", "br", "politico", "politica")

clean_self_term <- function(x) {
  x %>%
    stringi::stri_trans_general(id = "Latin-ASCII") %>%
    stringr::str_to_lower() %>%
    stringr::str_replace_all("[^a-z0-9]", " ") %>%
    stringr::str_squish()}

collapse_self_term <- function(x) {
  x %>%
    stringi::stri_trans_general(id = "Latin-ASCII") %>%
    stringr::str_to_lower() %>%
    stringr::str_replace_all("[^a-z0-9]", "") %>%
    stringr::str_trim()}

make_token_variants <- function(tokens) {
  tokens <- tokens[
    tokens != "" &
      !tokens %in% generic_profile_terms]
  tokens <- unique(tokens)
  
  # Basic typo
  plural_variants <- paste0(tokens, "s")
  # Variants where final "o" becomes "r" due to lemmatization 
  final_o_to_r <- stringr::str_replace(tokens, "o$", "r")
  final_do_to_r <- stringr::str_replace(tokens, "do$", "r")
  
  unique(c(
    tokens,
    plural_variants,
    final_o_to_r,
    final_do_to_r))}

make_self_terms <- function(author, page_name) {
  
  author_clean <- clean_self_term(author)
  page_clean   <- clean_self_term(page_name)
  
  author_tokens <- author_clean %>%
    stringr::str_split("\\s+") %>%
    unlist()
  
  page_tokens <- page_clean %>%
    stringr::str_split("\\s+") %>%
    unlist()
  
  all_tokens <- unique(c(author_tokens, page_tokens))
  
  all_tokens <- all_tokens[
    all_tokens != "" &
      !all_tokens %in% generic_profile_terms
  ]
  
  # Collapsed variants
  author_no_space <- paste0(author_tokens, collapse = "")
  page_collapsed  <- paste0(page_tokens[!page_tokens %in% generic_profile_terms], collapse = "")
  tokens_collapsed <- paste0(all_tokens, collapse = "")
  
  # Remove common prefixes/suffixes from collapsed author string
  author_variants <- author_no_space %>%
    stringr::str_replace_all(
      "(oficial|dep|deputado|deputada|federal|senador|senadora)$",
      ""
    ) %>%
    stringr::str_replace_all(
      "^(oficial|dep|deputado|deputada|federal|senador|senadora)",
      ""
    ) %>%
    stringr::str_replace_all("[0-9]+$", "")
  
  # Prefix variants, e.g. juliocesar -> depjuliocesar / depfederaljuliocesar
  prefix_variants <- c(
    paste0("dep", all_tokens),
    paste0("depfederal", all_tokens),
    paste0("deputado", all_tokens),
    paste0("deputada", all_tokens),
    paste0("dep", tokens_collapsed),
    paste0("depfederal", tokens_collapsed),
    paste0("deputado", tokens_collapsed),
    paste0("deputada", tokens_collapsed)
  )
  
  token_variants <- make_token_variants(all_tokens)
  
  collapsed_variants <- make_token_variants(c(
    author_no_space,
    page_collapsed,
    tokens_collapsed,
    author_variants
  ))
  
  unique(c(
    author_clean,
    author_no_space,
    author_variants,
    page_clean,
    page_tokens,
    page_collapsed,
    all_tokens,
    token_variants,
    collapsed_variants,
    prefix_variants
  ))
}

account_self_terms <- df_fb %>%
  dplyr::distinct(author, page_name) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    term = list(make_self_terms(author, page_name))
  ) %>%
  tidyr::unnest(term) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(
    term = collapse_self_term(term)
  ) %>%
  dplyr::filter(
    term != "",
    nchar(term) > 2,
    !term %in% generic_profile_terms,
    !term %in% custom_stopwords
  ) %>%
  dplyr::distinct(author, term)

# Exceptional cases
manual_self_terms <- c(
  "bacelars", "juniors", "abreus", "helder", "rogerio", "mariaroso",
  "amaquino", "martinss", "depjuliocesar", "depfederaljuliocesar",
  "aroldomartim", "gomess", "marcospereiro", "ronaldocaiar", "caiar",
  "heleninha", "manoel") %>%
  collapse_self_term() %>%
  unique()

account_self_terms <- account_self_terms %>%
  dplyr::bind_rows(
    df_fb %>%
      dplyr::distinct(author) %>%
      tidyr::crossing(term = manual_self_terms)
  ) %>%
  dplyr::filter(
    term != "",
    nchar(term) > 2,
    !term %in% generic_profile_terms,
    !term %in% custom_stopwords
  ) %>%
  dplyr::distinct(author, term)