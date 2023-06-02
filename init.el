(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load my org mode config
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" default))
 '(package-selected-packages
   '(zenburn-theme csharp-mode haskell-mode company-go go-mode org-present auto-package-update rjsx-mode json-mode emmet-mode markdown-mode yasnippet yasnippet-snippets js2-mode company-tern pyvenv company-jedi company-web web-mode diminish company company-mode rainbow-delimiters hungry-delete rainbow-mode avy smex ido-vertical-mode org-bullets which-key use-package))
 '(warning-suppress-types '((comp) (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
