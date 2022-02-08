require_relative "objects/general_orders"
require_relative "objects/history"
require_relative "objects/chain_of_command"
require_relative "objects/rates_and_ranks"
require_relative "objects/firearm_safety_rules"
require_relative "objects/uscg_ethos"
require_relative "objects/core_values"

require_relative "objects/nonessential/grooming_standards"
require_relative "objects/nonessential/uniforms"
require_relative "objects/nonessential/nonrate_enlisted_evaluation_system"
require_relative "objects/nonessential/knots"
require_relative "objects/nonessential/semper_paratus"
require_relative "objects/nonessential/m16_nomenclature"
require_relative "objects/nonessential/classes_of_fire"
require_relative "objects/nonessential/nautical_terminology"
require_relative "objects/nonessential/force_protection_conditions"
require_relative "objects/nonessential/roles_and_missions"
require_relative "objects/nonessential/international_code_of_signals"
require_relative "objects/nonessential/miscellaneous"
require_relative "objects/nonessential/enlisted_ratings"

ESSENTIAL_FOCUS_ARGS = {
  "CHAIN_OF_COMMAND" => CHAIN_OF_COMMAND_QUESTIONS,
  "CORE_VALUES" => ESSENTIAL_CORE_VALUES_QUESTION,
  "FIREARM_SAFETY_RULES" => FIREARM_SAFETY_RULES_QUESTIONS,
  "GENERAL_ORDERS" => GENERAL_ORDERS_QUESTIONS,
  "HISTORY" => HISTORY_QUESTIONS,
  "RATES_AND_RANKS" => RATES_AND_RANKS_QUESTIONS,
  "USCG_ETHOS" => USCG_ETHOS_QUESTION, # only one question that is essential (what is the ethos)
}

SPECIAL_FOCUS_ARGS = {
  "LIST_ALL_ENLISTED_RATINGS" => LIST_ALL_ENLISTED_RATINGS_QUESTIONS,
  "FLAG_MEANINGS" => FLAG_MEANINGS_IN_ORDER,
  "NAUTICAL_TERMINOLOGY_WORDS_IN_ORDER" => NAUTICAL_TERMINOLOGY_WORDS_IN_ORDER,
  "LIST_ALL_M16" => LIST_ALL_M16_NOMENCLATURE_QUESTIONS,
}

NONESSENTIAL_FOCUS_ARGS = {
  "GROOMING_STANDARDS" => GROOMING_STANDARDS_QUESTIONS,
  "UNIFORMS" => UNIFORMS_QUESTIONS,
  "NONRATE_ENLISTED_EVALUATION_SYTEM" => NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS,
  "NONRATE_EES" => NONRATE_ENLISTED_EVALUATION_SYSTEM_QUESTIONS,
  "KNOTS" => KNOTS_QUESTIONS,
  "CORE_VALUES" => NONESSENTIAL_CORE_VALUES_QUESTIONS,
  "SEMPER_PARATUS" => SEMPER_PARATUS_QUESTIONS,
  "M16_NOMENCLATURE" => M16_NOMENCLATURE_QUESTION,
  "CLASSES_OF_FIRE" => CLASSES_OF_FIRE_QUESTIONS,
  "FORCE_PROTECTION_CONDITIONS" => FORCE_PROTECTION_CONDITIONS_QUESTIONS,
  "NAUTICAL_TERMINOLOGY" => NAUTICAL_TERMINOLOGY_QUESTIONS,
  "ROLES_AND_MISSIONS" => ROLES_AND_MISSIONS_QUESTIONS,
  "INTERNATIONAL_CODE_OF_SIGNALS" => INTERNATIONAL_CODE_OF_SIGNALS_QUESTIONS,
  "MISCELLANEOUS" => MISCELLANEOUS_QUESTIONS,
  "ENLISTED_RATINGS" => ENLISTED_RATINGS_QUESTIONS,
}

PHONETIC_FOCUS_ARGS = {
  "PHONETIC_RANKS_AND_RANKS" => PHONETIC_RATES_AND_RANKS_QUESTIONS,
  "PHONETIC_ENLISTED_RATINGS_QUESTIONS" => PHONETIC_ENLISTED_RATINGS_QUESTIONS,
}

FOCUS_ARGS = [ESSENTIAL_FOCUS_ARGS, NONESSENTIAL_FOCUS_ARGS, SPECIAL_FOCUS_ARGS, PHONETIC_FOCUS_ARGS]

USER_CHOICE_ARGS = {
  "Go back [n] questions" => ["repeat", "r", "back", "b"], # i.e. "back [n]"
  "Restart questions from the beginning" => ["restart", "rs", "start_over", "so", "beginning"],
  "Print instructions" => ["instructions", "i"],
  "Quit program" => ["quit", "q"],
}