(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(menu-bar-mode nil)
 '(package-selected-packages
   '(company-coq proof-general ewal-spacemacs-themes ewal which-key rainbow-delimiters elpy blacken company-web web-beautify company-web-slim company-web-jade company-web-html multi-web-mode lsp-ivy python-mode markdown-preview-eww markdown-mode magit counsel projectile dap-mode exec-path-from-shell rustic rust-mode lsp-mode autothemer))
 '(tool-bar-mode nil)
 )

;; set backups to .emacs.d folder
;;(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
;;  backup-by-copying t    ; Don't delink hardlinks
;;  version-control t      ; Use version numbers on backups
;;  delete-old-versions t  ; Automatically delete excess backups
;;  kept-new-versions 20   ; how many of the newest versions to keep
;;  kept-old-versions 5    ; and how many of the old
;;  )
(setq make-backup-files nil) ; stop creating backup files
(setq create-lockfiles nil) ; stop creating lockfiles (those .# files)

(setq inhibit-startup-message t)
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
	       term-mode-hook
	       shell-mode-hook
	       eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-frame-parameter nil 'alpha-background 80)

(add-to-list 'default-frame-alist '(alpha-background . 70))

;; keep the cursor centered to avoid sudden scroll jumps
(require 'centered-cursor-mode
   :ensure)

;; disable in terminal modes
;; http://stackoverflow.com/a/6849467/519736
;; also disable in Info mode, because it breaks going back with the backspace key
(define-global-minor-mode my-global-centered-cursor-mode centered-cursor-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'Info-mode 'term-mode 'eshell-mode 'shell-mode 'erc-mode)))
      (centered-cursor-mode))))
(my-global-centered-cursor-mode 1)

(use-package autothemer
  :ensure)

(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ewal-built-in-palette "sexy-material"))
(use-package ewal-spacemacs-themes
  :init (progn
          (setq spacemacs-theme-underline-parens t
                my:rice:font (font-spec
                              :family "FiraCode Nerd Font Mono"
                              :weight 'semi-bold
                              :size 11.0))
          (show-paren-mode +1)
          (global-hl-line-mode)
          (set-frame-font my:rice:font nil t)
          (add-to-list  'default-frame-alist
                        `(font . ,(font-xlfd-name my:rice:font))))
  :config (progn
            (load-theme 'ewal-spacemacs-modern t)
            (enable-theme 'ewal-spacemacs-modern)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 1)
  (setq which-key-popup-type 'minibuffer))

(use-package counsel
  :ensure
  :config
  (counsel-mode +1)
  (ivy-mode +1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package projectile
  :ensure
  :init
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/work/"))
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

(use-package magit
  :ensure)

(use-package treemacs
  :ensure)
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure)
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure)
(use-package lsp-treemacs
  :after (treemacs lsp-mode)
  :ensure)
(lsp-treemacs-sync-mode 1)
(treemacs-start-on-boot)

;; LSP setup
(use-package lsp-ivy
  :ensure)

(use-package lsp-mode
  :ensure
  :commands lsp
  :bind (:map rustic-mode-map
              ("M-j" . lsp-treemacs-symbols)
              ("M-?" . lsp-treemacs-references)
	      ("M-!" . lsp-treemacs-implementations)
              ("C-c C-c l" . flycheck-list-errors)
	      ("C-c C-c t" . lsp-inlay-hints-mode)
	      ("C-c C-c S" . lsp-ivy-workspace-symbol))
  :init
  (setq lsp-keymap-prefix "C-c C-l"))
  :custom
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.3)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))


;; Company setup
(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last))
  (:map company-mode-map
	("<tab>". tab-indent-or-complete)
	("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

;; flycheck
(use-package flycheck :ensure)

(use-package rust-mode
  :ensure)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode))
:init (setq markdown-command "/usr/bin/multimarkdown"))

(use-package multi-web-mode
  :ensure
  :config
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags
	'((js-mode "<script[^>]*>" "</script>")
	  (css-mode "<style[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("htm" "html" "phtml"))
  (multi-web-global-mode 1))




;; Rust setup
(use-package rustic
  :ensure
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

;; Python setup
(use-package blacken
  :ensure)

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  
  ;; Enable Flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

;; debugging setup
(use-package exec-path-from-shell
  :ensure
  :init (exec-path-from-shell-initialize))

(use-package company-web
  :ensure)

(use-package web-beautify
  :ensure
  :config
  (eval-after-load 'multi-web-global-mode
  '(add-hook 'mweb-mode-hook
	     (lambda ()
               (add-hook 'before-save-hook 'web-beautify-html-buffer t t)))))

;; remove the suspend keybind when in graphical mode as it
;; frequently 'closes' emacs and (at least with a tiling wm)
;; and you cannot reopen it
(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-z C-z") 'my-suspend-frame)

(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package company-coq
  :hook (coq-mode . company-coq-mode))
