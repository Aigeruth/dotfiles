
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
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
  (org-habit-show-habits-only-for-today nil)
  (org-hide-leading-stars t)
  (org-log-done 'time)
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-startup-indented t)
  (org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
          (sequence "|" "CANCELED(c)")))
  :config
  (require 'org-checklist)
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
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
(setq org-capture-templates
  `(
    ("5" "5 minutes journal" entry (file+datetree "~/org/5-minutes-journal.org")
     ,(concat "* Morning\n"
             "** I am grateful for... (3x)\n"
             "1.\n"
             "** What would make today great? (3x)\n"
             "1.\n"
             "** Daily affirmations. I am...\n"
             "* Evening\n"
             "** 3 amazing things that happened today...\n"
             "1.\n"
             "** How could I have made today better?\n"))
    ("j" "Journal entry" entry (function org-journal-find-location)
         "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
  )
)

(use-package rg
  :ensure-system-package (rg . "brew install ripgrep"))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package ledger-mode
  :pin melpa
  :mode "\\.ledger\\'"
  :config
  (setq ledger-default-date-format ledger-iso-date-format)
)
(use-package flycheck-ledger
  :pin melpa
  :after ledger-mode)
(use-package evil-ledger
  :after ledger-mode)

(use-package plantuml-mode
  :mode "\\.plantuml\\'")
(use-package flycheck-plantuml
  :after plantuml-mode
  :config
  (flycheck-plantuml-setup))

(use-package markdown-mode
  :ensure-system-package (multimarkdown . "brew install multimarkdown")
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package evil
  :config
  (evil-mode)
)
(use-package evil-org
  :after (org evil)
  :custom
  (evil-want-C-i-jump nil)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  :hook
  (org-mode . evil-org-mode)
  (evil-org-mode . (lambda ()(evil-org-set-key-theme)))
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
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default)))
 '(package-selected-packages
   (quote
    (magit dracula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs configuration
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;; Appearance
(load-theme 'dracula t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light))
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;;; .emacs ends here
