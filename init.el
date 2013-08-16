
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
			undo-tree))

  (dolist (p my-packages)
    (when (not (package-installed-p p)) (package-install p)))

  ;; theme
  (load-theme 'zenburn t)

  ;; hook
  (add-hook 'clojure-mode-hook 'paredit-mode)

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
  (global-undo-tree-mode 1))
  
(add-hook 'after-init-hook 'my-package-complete)
