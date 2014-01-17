
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(set-face-attribute 'default nil :height 150)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")


;; mac osx pound sign
(global-set-key (kbd "M-3") (lambda () (interactive) (insert "#")))
(define-key global-map (kbd "C-c 3") (lambda () (interactive) (insert "#")))

(require 'cl)
(require 'package)
(add-to-list 'package-archives
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/") t)

;; (add-to-list 'package-archives
;; 	     '("marmalade" .
;; 	       "http://marmalade-repo.org/packages/"))

(package-refresh-contents)
(package-initialize)

(defvar my-packages '(dash
		      clojure-mode
		      clojure-test-mode
		      cider
		      pkg-info
		      gist
		      ;; clojurescript-mode
		      ;; cljdoc
		      align-cljlet
		      ;; cljsbuild-mode
		      eldoc
		      paredit
		      auto-complete
		      ac-nrepl
		      magit
		      zenburn-theme
		      git-gutter
		      undo-tree
		      cl-lib
		      rainbow-delimiters
		      highlight-parentheses
		      yaml-mode
		      ;; graphviz-dot-mode
		      exec-path-from-shell
		      sass-mode
		      ;; org
		      ))

(dolist (p my-packages)
  (when (not (package-installed-p p)) (package-install p)))

(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; magit
(global-set-key (kbd "C-c C-g") 'magit-status)
(global-set-key (kbd "C-c C-b") 'magit-blame-mode)

;; theme
(load-theme 'zenburn t)

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


;; CIDER
(require 'eldoc)
(require 'cider)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(setq cider-repl-history-file "~/.emacs.d/cider-history")

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)

(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'cider-repl-hook-mode 'ac-nrepl-setup)
(add-hook 'cider-mode 'ac-nrepl-setup)

;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'cider-repl-mode))

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))


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
	       ("Mobile"
		(filename . "Projects/cordova"))
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
 
;; hook
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)


(require 'popup)

(defun describe-thing-in-popup ()
  (interactive)
  (let* ((thing (symbol-at-point))
         (help-xref-following t)
         (description (with-temp-buffer
                        (help-mode)
                        (help-xref-interned thing)
                        (buffer-string))))
    (popup-tip description
               :point (point)
               :around t
               :height 30
               :scroll-bar t
               :margin t)))

(global-set-key (kbd "M-5") 'describe-thing-in-popup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/org/keeds.org"
			    "~/Dropbox/org/bom.org"
			    "~/Dropbox/org/plan.org"
			    "~/Dropbox/org/infra.org"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
