;; extends

; night-owl.nvim's after-queries capture this colon as @keyword.operator for
; every colorscheme; keep it punctuation.
(type_annotation ":" @punctuation.delimiter (#set! priority 101))
