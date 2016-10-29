(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-files-not-to-save "nil")
 '(desktop-path (quote ("~/.emacs.d/" "~")))
 '(inhibit-startup-screen t)
 '(js-indent-level 4)
 '(package-selected-packages
   (quote
    (paredit-everywhere multi-web-mode js2-refactor ido-vertical-mode helm evil cl-lib-highlight auto-complete ac-js2)))
 '(scheme-program-name "C:\\Users\\B65984\\Racket\\mzscheme")
 '(tab-width 4)
 '(tramp-default-method "ftp"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; MELPA package archives
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Make indentation using spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Make ftp connection to TEST development and switch to that buffer
;;(dired "/b65984@W96370:/RWC/TEST/b65984")
(desktop-save-mode t)
(show-paren-mode t)
(setq perl-indent-level tab-width)
(add-to-list 'auto-mode-alist '("\\.\\(profile\\)$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

(require 'yasnippet)
(yas-global-mode 1)

;; Paredit
(autoload
 'enable-paredit-mode
 "paredit"
 "Turn on pseudo-structural editing of Lisp code."
 t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'prog-mode-hook 'paredit-everywhere-mode)

(require 'cl-lib-highlight)
(cl-lib-highlight-initialize)

(require 'evil)

(put 'narrow-to-region 'disabled nil)

;; Helm
(defvar fuzzy-helper 'helm "Choose ido or helm")
(cl-case fuzzy-helper
  ('helm
   (progn
     (require 'helm-config)
     (global-set-key (kbd "M-x")     #'helm-M-x)
     (global-set-key (kbd "C-x C-m") #'helm-M-x)
     (global-set-key (kbd "M-y")     #'helm-show-kill-ring)
     (global-set-key (kbd "C-x b")   #'helm-mini)
     (global-set-key (kbd "C-x C-b") #'helm-buffers-list)
     (global-set-key (kbd "C-x C-f") #'helm-find-files)
     (global-set-key (kbd "C-h f")   #'helm-apropos)
     (global-set-key (kbd "C-h r")   #'helm-info-emacs)
     (global-set-key (kbd "C-h C-l") #'helm-locate-library)

     (setq helm-mode-fuzzy-match t)
     (setq helm-completion-in-region-fuzzy-match t)))
  ('ido
   (progn
     (ido-mode t)
     ;; Display ido results vertically, rather than horizontally
     (setq ido-enable-flex-matching t)
     (setq ido-everywhere t)
     (ido-vertical-mode 1)
     (setq do-vertical-define-keys 'C-n-and-C-p-on))))

;; ;; Activate ido

;; Autocomplete
(ac-config-default)
(global-auto-complete-mode t)

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; html-files
(progn
  (require 'multi-web-mode)
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                    (js-mode  "<script *\\(:?type=\"text/javascript\"\\|language=\"javascript\"\\)?[\s]*>" "</script>")
                    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
  (multi-web-global-mode 1))
