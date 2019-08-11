
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; It is likely that GNU Elpa has changed its default TLS version
; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/etw48ux/
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

(use-package use-package-ensure-system-package)
(use-package auto-package-update
  :init
  (setq auto-package-update-prompt-before-update t)
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-maybe)
)

(setenv "PATH" (concat
  (getenv "PATH")
  ":" (substitute-in-file-name "$HOME/bin")
  ":/usr/local/bin")
)
(setq exec-path (append exec-path '((substitute-in-file-name "$HOME/bin"))))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Spelling
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-dictionary "en_GB")
  (setq ispell-local-dictionary "en_GB")
  (setq ispell-local-dictionary-alist
	  ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
	  ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
	'(("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB") nil utf-8))
  )
)

; GPG config
(setq epa-pinentry-mode 'loopback)

; OrgMode configuration
(use-package org
  :pin org
  :ensure org-plus-contrib
  :bind (
    ("\C-cl" . org-store-link)
    ("\C-ca" . org-agenda)
    ("\C-cc" . org-capture)
    ("\C-cb" . org-switchb)
  )
  :custom
  (org-agenda-files (directory-files-recursively "~/org/" "\.org$"))
  (org-export-backends (quote (ascii html md)))
  (org-hide-leading-stars t)
  (org-log-done 'note)
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-startup-indented t)
  (org-stuck-projects
      '("+project/-MAYBE-DONE" ("NEXT" "TODO") ("@shop"))
  )
  (org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
          (sequence "|" "CANCELED(c)")))
  :config
  (require 'org-checklist)
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (calc . t)
     (dot . t)
     (plantuml . t)
     (python . t)
     (shell . t)
     )
   )
  :hook
  (text-mode . visual-line-mode)
  (org-mode . turn-on-flyspell)
)
;; Hide leading stars
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
)
(use-package org-journal
  :after org
  :config
  (defun org-journal-find-location ()
    ;; Open today's journal, but specify a non-nil prefix argument in order to
    ;; inhibit inserting the heading; org-capture will insert the heading.
    (org-journal-new-entry t)
    ;; Position point on the journal's top-level heading so that org-capture
    ;; will add the new entry as a child entry.
    (goto-char (point-min)))
)
(org-babel-load-file "~/dotfiles/org-mode/config.org")
(use-package alert
  :custom
  (alert-default-style 'osx-notifier)
)
(use-package org-alert
  :config
  (org-alert-disable)
)

(use-package helm
  :config
  (helm-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-week-start-day 1)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs configuration
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;;; .emacs ends here
