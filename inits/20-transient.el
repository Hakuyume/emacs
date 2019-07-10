(use-package dired)

(use-package transient
  :bind ("C-q" . transient-dashboard)
  :config
  (progn
    (define-transient-command transient-dashboard ()
      [[("e" "Flycheck" helm-flycheck)]
       [("g" "Grep" transient-dashboard-grep)]
       [("h" "Helm" helm-mini)]
       [("H" "Helm (full)" transient-dashboard-helm-full)]
       [("j" "Goto Line" goto-line)]
       [("l" "LSP" transient-dashboard-lsp)]
       [("m" "Magit" magit-status)]
       [("r" "Rsync" transient-dashboard-rsync)]])

    (define-transient-command transient-dashboard-grep ()
      [[("g" "Git Grep" transient-dashboard-grep-git-grep)]
       [("p" "Grep" helm-projectile-grep)]])

    (defun transient-dashboard-grep-git-grep ()
      (interactive)
      (let ((default-directory (magit-toplevel))) (helm-grep-do-git-grep t)))

    (defun transient-dashboard-helm-full ()
      (interactive)
      (use-package helm-projectile)
      (let ((helm-mini-default-sources
             '(helm-source-buffers-list
               helm-source-recentf
               helm-source-projectile-files-list)))
        (helm-mini)))

    (define-transient-command transient-dashboard-lsp ()
      [[("d" "Definition" lsp-find-definition)]
       [("i" "Implementation" lsp-find-implementation)]
       [("r" "Rename" lsp-rename)]])

    (defun transient-dashboard-rsync ()
      (interactive)
      (helm
       :sources (helm-build-in-file-source
                    "Rsync" (expand-file-name ".rsync-remotes" (magit-toplevel))
                    :action (lambda (remote)
                              (let ((default-directory (magit-toplevel)))
                                (set-process-sentinel
                                 (start-process "rsync" "*rsync*"
                                                "rsync" "-acv" "--delete"
                                                "--exclude=.rsync-remotes"
                                                "--exclude=.git/"
                                                "--exclude-from=.gitignore"
                                                "./" remote)
                                 (lambda (process event)
                                   (message (format "%s: %s"
                                                    (mapconcat 'identity (process-command process) " ")
                                                    event)))))))
       :buffer "*helm rsync*")))
  :demand)
