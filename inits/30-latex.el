(add-hook 'latex-mode-hook 'indent-guide-mode)
(add-hook 'latex-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command) "make")
            (set (make-local-variable 'compilation-read-command) nil)
            (define-key latex-mode-map "\C-c\C-c" 'compile)
            (make-local-variable 'helm-mini-default-sources)
            (add-to-list 'helm-mini-default-sources helm-source-latex-symbols)
            (yas-minor-mode)
            (add-to-list 'helm-mini-default-sources helm-source-yasnippet)
            (reftex-mode)
            (add-to-list 'helm-mini-default-sources helm-source-reftex)))
(eval-after-load "reftex"
  '(progn
     (setq reftex-refstyle "\\ref")
     (defvar helm-source-reftex
       '((name . "RefTeX")
         (candidates . (("ref" . reftex-reference)
                        ("cite" . reftex-citation)
                        ("label" . reftex-label)))
         (action . command-execute)))))
(eval-after-load "popwin"
  '(progn
     (push '("reftex" :regexp t) popwin:special-display-config)))
(eval-after-load "helm"
  '(progn
     (defvar helm-source-latex-symbols
       (helm-build-sync-source "Symbols"
         :candidates (mapcar (lambda (symbol)
                               (cons (concat (cdr symbol) "\t" (car symbol)) (concat "\\" (car symbol))))
                             latex-symbols)
         :action 'insert))))
(defvar latex-symbols
  '(("alpha" . "α")
    ("beta" . "β")
    ("gamma" . "γ")
    ("delta" . "δ")
    ("epsilon" . "ε")
    ("varepsilon" . "ε")
    ("zeta" . "ζ")
    ("eta" . "η")
    ("theta" . "θ")
    ("kappa" . "κ")
    ("lambda" . "λ")
    ("mu" . "μ")
    ("nu" . "ν")
    ("xi" . "ξ")
    ("pi" . "π")
    ("rho" . "ρ")
    ("sigma" . "σ")
    ("tau" . "τ")
    ("upsilon" . "υ")
    ("phi" . "φ")
    ("varphi" . "φ")
    ("chi" . "χ")
    ("psi" . "ψ")
    ("omega" . "ω")
    ("Gamma" . "Γ")
    ("Delta" . "Δ")
    ("Theta" . "Θ")
    ("Lambda" . "Λ")
    ("Xi" . "Ξ")
    ("Pi" . "Π")
    ("Sigma" . "Σ")
    ("Upsilon" . "Υ")
    ("Phi" . "Φ")
    ("Psi" . "Ψ")
    ("Omega" . "Ω")
    ("infty" . "∞")
    ("pm" . "±")
    ("mp" . "∓")
    ("cap" . "∩")
    ("cup" . "∪")
    ("wedge" . "∧")
    ("vee" . "∨")
    ("leq" . "≦")
    ("geq" . "≧")
    ("ll" . "<<")
    ("gg" . ">>")
    ("subset" . "⊂")
    ("subseteq" . "⊆")
    ("supset" . "⊃")
    ("supseteq" . "⊇")))
