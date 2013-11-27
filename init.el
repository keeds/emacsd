
<<<<<<< HEAD
(defun my-package-complete ()

  (require 'package)
  (add-to-list 'package-archives
	       ;; '("melpa" . "http://melpa.milkbox.net/packages/")
	       '("marmalade" . "http://marmalade-repo.org/packages/")
	       )
  (package-refresh-contents)
  (package-initialize)

  (defvar my-packages '(clojure-mode
 			clojurescript-mode
			clojure-test-mode
			cider
			cljdoc
			align-cljlet
			cljsbuild-mode
			eldoc
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
			yaml-mode
			graphviz-dot-mode
			org
			))

  (dolist (p my-packages)
    (when (not (package-installed-p p)) (package-install p)))


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
=======
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)


;; mac osx pound sign
(global-set-key (kbd "M-3") (lambda () (interactive) (insert "#")))
(define-key global-map (kbd "C-c 3") (lambda () (interactive) (insert "#")))

;; window management
;; (winner-mode)

;; (global-set-key (kbd "C-c <C-left>")  'windmove-left)
;; (global-set-key (kbd "C-c <C-right>") 'windmove-right)
;; (global-set-key (kbd "C-c <C-up>")    'windmove-up)
;; (global-set-key (kbd "C-c <C-down>")  'windmove-down)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))

;; (package-refresh-contents)
(package-initialize)

(defvar my-packages '(clojure-mode
		      clojurescript-mode
		      clojure-test-mode
		      cider
		      ;; clojure-cheatsheet
		      ;; clojure-snippets
		      cljdoc
		      align-cljlet
		      cljsbuild-mode
		      eldoc
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
		      ;; pg
		      yaml-mode
		      graphviz-dot-mode
		      ;; helm
		      ;; org
		      ;; org-trello
		      ;; org-journal
		      ;; smartparens
		      ;; htmlize
		      ))

(dolist (p my-packages)
  (when (not (package-installed-p p)) (package-install p)))


;; magit
(global-set-key (kbd "C-c C-g") 'magit-status)
(global-set-key (kbd "C-c C-b") 'magit-blame-mode)

;; (golden-ratio-mode 1)

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

(load-theme 'zenburn t)

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
>>>>>>> tweak init.el
  
;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;; git-gutter
(global-git-gutter-mode t)

;; parens
(require 'rainbow-delimiters)
(require 'highlight-parentheses)

<<<<<<< HEAD
  (require 'cljdoc)

  ;; align-cljlet
  (require 'align-cljlet)
  (global-set-key (kbd "C-M-z") 'align-cljlet)
=======
;; align-cljlet
(require 'align-cljlet)
(global-set-key (kbd "C-M-z") 'align-cljlet)
>>>>>>> tweak init.el

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

(dolist (mode '(clojure-mode lisp-mode magit-log-edit-mode))
  (add-to-list 'ac-modes mode))

<<<<<<< HEAD
  ;; CIDER
  (require 'cider)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

  ;; (setq nrepl-hide-special-buffers t)

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
		 ("Poles"
		  (filename . "Projects/poles"))
		 ("Casca"
		  (filename . "Projects/casca"))
		 ("Programming" ;; prog stuff not already in MyProject
		  (or
		   (mode . emacs-lisp-mode)
		   (mode . clojure-mode)
		   ;; etc
		   ))))))
  
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-switch-to-saved-filter-groups "default")))
=======
  ;; (require 'smartparens-config)
  ;; (smartparens-global-strict-mode t)
  ;; (show-smartparens-global-mode t)

  ;; (define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
  ;; (define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
  ;; (define-key sp-keymap (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
  ;; (define-key sp-keymap (kbd "C-M-<right>") 'sp-backward-barf-sexp)

;; CIDER
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(setq cider-repl-history-file "~/.emacs.d/cider-history")

(require 'cider)
(add-hook 'cider-repl-mode-hook 'subword-mode)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)

(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

;; (setq nrepl-hide-special-buffers t)

;; nrepl
;; (require 'nrepl)
;; (require 'ac-nrepl)
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
;; (add-hook 'nrepl-interaction-mode-hook
;; 	  'nrepl-turn-on-eldoc-mode)

;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'nrepl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

;; (defun live-nrepl-set-print-length ()
;;   (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))
;; (add-hook 'nrepl-connected-hook 'live-nrepl-set-print-length)


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
	       ("Poles"
		(filename . "Projects/poles"))
	       ("Casca"
		(filename . "Projects/casca"))
	       ("phonegap"
		(filename . "Projects/phonegap"))
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

;; clojure-mode
(setq clojure-defun-style-default-indent t)
>>>>>>> tweak init.el
  
;; hook
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

<<<<<<< HEAD
  ;; clojure-mode
  (setq clojure-defun-style-default-indent t)
  
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
=======
;; (add-hook 'nrepl-mode-hook 'paredit-mode)
;; (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'nrepl-mode-hook 'highlight-parentheses-mode)
>>>>>>> tweak init.el


;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/org/2013/2013-plan.org"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
