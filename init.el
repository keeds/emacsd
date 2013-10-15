
(defun my-package-complete ()

  (require 'package)
  (add-to-list 'package-archives
	       ;; '("melpa" . "http://melpa.milkbox.net/packages/")
	       '("marmalade" . "http://marmalade-repo.org/packages/")
	       )
  (package-refresh-contents)
  (package-initialize)

  (defvar my-packages '(clojure-mode
			;; clojure-cheatsheet
			;; clojure-snippets
			align-cljlet
			cljsbuild-mode
			paredit
			nrepl
			auto-complete
			ac-nrepl
			magit
			zenburn-theme
			git-gutter
			undo-tree
			cl-lib
			dash
			rainbow-delimiters
			highlight-parentheses
			pg
			yaml-mode
			graphviz-dot-mode
			;; helm
			org
			org-journal))

  (dolist (p my-packages)
    (when (not (package-installed-p p)) (package-install p)))

  ;; HELM
  ;; (require 'helm)
  ;; (helm-mode 1)

  ;; (defun helm-clojure-headlines ()
  ;;   "Display headlines for the current Clojure file."
  ;;   (interactive)
  ;;   (helm :sources '(((name . "Clojure Headlines")
  ;; 		      (volatile)
  ;; 		      (headline "^[;(]")))))

  ;; (global-set-key (kbd "C-c ;") 'helm-clojure-headlines)

  
  ;; theme
  (load-theme 'zenburn t)

  ;; setup
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (setq inhibit-startup-screen t)
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; ido
  (require 'ido)
  (ido-mode t)

  ;; scrolling
  (setq scroll-margin 0
	scroll-conservatively 100000
	scroll-preserve-screen-position 1)


  ;; line numbers
  (line-number-mode t)
  (column-number-mode t)
  (size-indication-mode t)

  
  ;; undo-tree
  (require 'undo-tree)
  (global-undo-tree-mode 1)


  ;; git-gutter
  (global-git-gutter-mode t)


  ;; parens
  (require 'rainbow-delimiters)
  (require 'highlight-parentheses)

  
  ;; smartparens
  ;; (require 'smartparens-config)


  ;; align-cljlet
  (require 'align-cljlet)
  (global-set-key (kbd "C-M-z") 'align-cljlet)


  ;; auto-complete
  (require 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)

  (dolist (mode '(clojure-mode lisp-mode magit-log-edit-mode))
    (add-to-list 'ac-modes mode))
  

  ;; nrepl
  (require 'nrepl)
  (require 'ac-nrepl)
  (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
  (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
  (add-hook 'nrepl-interaction-mode-hook
	    'nrepl-turn-on-eldoc-mode)

  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'nrepl-mode))


  (defun set-auto-complete-as-completion-at-point-function ()
    (setq completion-at-point-functions '(auto-complete)))

  (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

  (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
  (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

  (define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

  (defun live-nrepl-set-print-length ()
    (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))

  (add-hook 'nrepl-connected-hook 'live-nrepl-set-print-length)


  ;; postgres
  (require 'pg)


  ;; ibuffer
  (require 'ibuffer)

  (setq ibuffer-saved-filter-groups
	(quote (("default"      
		 ("Org" ;; all org-related buffers
		  (mode . org-mode))  
		 ("WS5"
		  (filename . "Projects/ws5"))
		 ("MRep"
		  (filename . "Projects/mrep"))
		 ("CMRMapping"
		  (filename . "Projects/cmrmapping"))
		 ("Programming" ;; prog stuff not already in MyProject
		  (or
		   (mode . emacs-lisp-mode)
		   (mode . clojure-mode)
		   ;; etc
		   ))))))
  
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-switch-to-saved-filter-groups "default")))
  
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  
  ;; mac osx pound sign
  (define-key global-map (kbd "C-c 3") (lambda () (interactive) (insert "#")))

  ;; hook
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

  (add-hook 'nrepl-mode-hook 'paredit-mode)
  (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
  
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  )
  
(add-hook 'after-init-hook 'my-package-complete)
