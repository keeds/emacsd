
(defun my-package-complete ()

  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/"))
	       ;; '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-refresh-contents)
  (package-initialize)

  (defvar my-packages '(clojure-mode
			clojure-cheatsheet
			clojure-snippets
			paredit
			nrepl
			ac-nrepl
			magit
			zenburn-theme
			git-gutter
			undo-tree
			cl-lib
			dash
			rainbow-delimiters
			highlight-parentheses
			pg))

  (dolist (p my-packages)
    (when (not (package-installed-p p)) (package-install p)))

  ;; theme
  (load-theme 'zenburn t)

  ;; setup
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (setq inhibit-startup-screen t)

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

  ;; nrepl
  (require 'nrepl)
  (require 'ac-nrepl)
  (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
  (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'nrepl-mode))

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
		 ("Programming" ;; prog stuff not already in MyProjectX
		  (or
		   (mode . emacs-lisp-mode)
		   (mode . clojure-mode)
		   ;; etc
		   ))))))
  
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-switch-to-saved-filter-groups "default")))
  
  (global-set-key (kbd "C-x C-b") 'ibuffer)

  ;; hook
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

  (add-hook 'nrepl-mode-hook 'paredit-mode)
  (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
  
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))
  
(add-hook 'after-init-hook 'my-package-complete)
