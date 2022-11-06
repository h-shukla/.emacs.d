(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
	auto-package-update-interval 7)
  (auto-package-update-maybe))

(set-frame-font "Cascadia Code 11")
;; (set-face-attribute 'region nil :background "#aaa")
(load-theme 'modus-operandi t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-screen t)
(save-place-mode 1)
(setq create-lockfiles nil)

;; Change scratch buffer behaviour
(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq make-backup-files nil)
(setq auto-save-default nil)

(electric-pair-mode 1)

(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(when window-system (set-frame-size (selected-frame) 80 44))
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
(if (eq system-type 'windows-nt)
    (cd "c:/Users/Himanshu/"))

(column-number-mode 1)
(delete-selection-mode 1)

(show-paren-mode 1)

(setq display-time-24hr-format t)
(display-time-mode 1)

(setq byte-compile-warnings '(not obsolete))

(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq-default smooth-scroll-margin 0)
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 100000)

;; Set transparency on startup
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 50))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 50)))

;; Toggle transparency with C-c t
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(95 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(setq org-src-window-setup 'current-window)
(add-hook 'org-mode-hook (lambda() (display-line-numbers-mode -1)))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda() (org-bullets-mode 1))))

(use-package org-present
  :ensure t
  :config
  (add-to-list 'load-path "~/path/to/org-present")
  (autoload 'org-present "org-present" nil t)
  (add-hook 'org-present-mode-hook
	    (lambda ()
	      (org-present-big)
	      (org-display-inline-images)))
  (add-hook 'org-present-mode-quit-hook
	    (lambda ()
	      (org-present-small)
	      (org-remove-inline-images))))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init(smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-expert t)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package rainbow-mode
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2))

(use-package company-web
  :ensure t
  :config
  (add-to-list 'company-backends 'company-web-mode)
  (add-hook 'web-mode-hook 'company-web-mode))

(use-package company-jedi
  :ensure t
  :config
  (add-to-list 'company-backends 'company-jedi))

(defun my/python-mode-hook ()
  (add-hook 'python-mode-hook 'my/python-mode-hook))

;; run pyenv-activate at the base of python project
(use-package pyvenv
  :ensure t
  :hook ((python-mode . pyvenv-mode)))

(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'which-key-mode)
  (diminish 'rainbow-mode))

(global-display-line-numbers-mode -1)
(add-hook 'dired-mode-hook (lambda() (display-line-numbers-mode -1)))

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>") 'ansi-term)

(add-hook 'term-mode-hook (lambda() (company-mode -1)))
(add-hook 'term-mode-hook (lambda() (display-line-numbers-mode -1)))
(add-hook 'eshell-mode-hook (lambda() (display-line-numbers-mode -1)))
(add-hook 'eshell-mode-hook (lambda() (company-mode -1)))

(use-package web-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode)))

(use-package json-mode
  :ensure t)

(use-package rjsx-mode
  :ensure t
  :mode "\\.js\\'")

(use-package yasnippet
  :ensure t
  :config 
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(defun my-limiting-hook()
  (auto-fill-mode t)
  (set-fill-column 80))
(add-hook 'markdown-mode-hook 'my-limiting-hook)
(add-hook 'org-mode-hook 'my-limiting-hook)

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  (add-hook 'rjsx-mode-hook 'emmet-mode))

(use-package go-mode
  :ensure t)

(use-package company-go
  :ensure t)

(use-package haskell-mode
  :ensure t)
