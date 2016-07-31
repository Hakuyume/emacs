(global-set-key "\C-xa" 'helm-mini)
(global-set-key "\M-y" 'helm-show-kill-ring)
(eval-after-load "helm"
  '(progn
     (define-key helm-map "\C-h" 'delete-backward-char)
     (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
     (custom-set-variables
      '(helm-mini-default-sources
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-files-in-current-dir
          helm-source-locate)))))
(eval-after-load "popwin"
  '(progn
     (push '("helm" :regexp t) popwin:special-display-config)))
(eval-after-load "magit"
  '(progn
     (define-key magit-mode-map "\C-xa" 'helm-mini)))