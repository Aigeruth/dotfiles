
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
  (require 'use-package))

(use-package auto-package-update
  :ensure t
  :init
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe)
)

(use-package org
  :ensure t
  :pin org
  :bind (
    ("\C-cl" . org-store-link)
    ("\C-ca" . org-agenda)
    ("\C-cc" . org-capture)
    ("\C-cb" . org-switchb)
  )
  :config
  (setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))
  (setq org-startup-indented t
        org-hide-leading-stars t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
          (sequence "|" "CANCELED(c)")))
  (setq org-log-done 'time)
)
; OrgMode configuration
;; Hide leading stars
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
)
(use-package org-journal
  :ensure t
)

(use-package rg
  :ensure t
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-week-start-day 1)
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default)))
 '(org-agenda-files (quote ("~/org/")))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (evil-ledger ledger-mode magit dracula-theme helm org-plus-contrib evil-numbers evil-org evil evil-tutor))))
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

; Evil mode configuration
; Enable table
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode 1)

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional))
(require 'org-checklist)
(require 'org-habit)

