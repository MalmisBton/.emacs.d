    (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; then define packages you use
;(use-package ace-jump-mode
;  :bind ("M-SPC" . ace-jump-mode))
;etc

(use-package evil)
  (require 'evil)
  (evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(tango-dark))
 '(elfeed-feeds '("https://planet.emacslife.com/atom.xml"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(package-selected-packages
   '(csv-mode smooth-scrolling elfeed hydra org-bullets ace-window company speed-type multi-term csharp-mode avy counsel ivy swiper jedi yasnippet-snippets yasnippet free-keys autotetris-mode 2048-game w3m groovy-mode evil))
 (use-package which-key)
 '(which-key-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))

;;evil-MODE
 ;(define-key evil-normal-state-map (kbd "ö") 'evil-forward-char)
 ;(define-key evil-normal-state-map (kbd "l") 'evil-previous-line)
 ;(define-key evil-normal-state-map (kbd "k") 'evil-next-line)
 ;(define-key evil-normal-state-map (kbd "j") 'evil-backward-char)


;;; SMOOTH SCROLLING
(use-package smooth-scrolling
  :init
  (setq redisplay-dont-pause t
        scroll-margin 1
        scroll-step 1
        scroll-conservatively 10000
        scroll-preserve-screen-position 1))

(setq inhibit-startup-message t)

;;Increment number at point
(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun decrement-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1- (string-to-number (match-string 0))))))

(global-set-key (kbd "s-a") 'increment-number-at-point)
(global-set-key (kbd "s-x") 'decrement-number-at-point)

;; AC
;;(ac-config-default)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

; 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;Which-key
(setq which-key-popup-type 'side-window)
;; Allow C-h to trigger which-key before it is done automatically
(setq which-key-show-early-on-C-h t)
;; make sure which-key doesn't show normally but refreshes quickly after it is
;; triggered.
(setq which-key-idle-delay 10000)
(setq which-key-idle-secondary-delay 0.05)
(which-key-mode)
(org-bullets-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
;(setq-local completion-ignore-case f)
;(company-dabbrev-code-ignore-case f)
;(company-dabbrev-ignore-case f)
;(setq company-dabbrev-ignore-case f)
;(setq company-dabbrev-downcase nil)
;(company-etags-ignore-case f)

;;HYDRA
(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out"))

;; SWIPER
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(cond ((file-exists-p "~/.emacs.d/my-alias.el")
       (load "~/.emacs.d/my-alias.el")))

(cond ((file-exists-p "~/.emacs.d/localsettings.el")
       (load "~/.emacs.d/localsettings.el")))

;;(setq initial-buffer-choice "~/.emacs.d/init.el")
;; Frame has the same title as file name
(setq-default frame-title-format '("%b"))
;; Replace case sensitive
(setq case-fold-replace nil)

;; Disable lock files
(setq create-lockfiles nil)


;; W3M
 (setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

;; Modes
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)
(setq display-line-numbers-type 'relative) 
(setq-default display-line-numbers 'realtive)
;;(global-set-key (kbd "s-d") 'delete-window)
(global-set-key (kbd "s-c") 'copy-to-register)
(global-set-key (kbd "s-b") 'balance-windows)
(global-set-key (kbd "s-o") 'other-window)
(global-set-key (kbd "s-r") 'undo-tree-redo)
(global-set-key (kbd "s-s") 'avy-goto-char)
(global-set-key (kbd "s-t") 'multi-term)
(global-set-key (kbd "s-v") 'insert-register)
(global-set-key (kbd "s-u") 'undo)
;(global-set-key (kbd "s-y") 'evil-yank-line)
;(global-set-key (kbd "\s-\t") 'org-global-cycle)
(global-set-key (kbd "s-1") 'org-global-cycle)


(show-paren-mode 1)
(blink-cursor-mode 0)
(add-to-list 'default-frame-alist'(fullscreen . maximized))

;;Emabled commands
(put 'dired-find-alternate-file 'disabled nil)


(global-set-key (kbd "M-s") 'avy-goto-char-2)

(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;(progn
  ;; define a prefix keymap
;  (define-prefix-command 'my-keymap)
;  (define-key my-keymap (kbd "c") 'initel)
;  (define-key my-keymap (kbd "<f7>") 'whitespace-mode)
;  (define-key my-keymap (kbd "<f8>") 'toggle-frame-fullscreen)
;  )

;(global-set-key (kbd "<esc>") my-keymap)

;; now, 【F9 F6】 will call visual-line-mode

(defun emacsd()
(interactive)
(find-file "~/.emacs.d/"))


(defun initel()
(interactive)
(find-file "~/.emacs.d/init.el"))

(use-package ace-window
  :ensure t
 :init
 (progn
   ;;Remapped this to itself because ACE window annoys me
	;; However: If the custom-set-faces is not in the init file, the avy config stuff wont work.
    (global-set-key [remap other-window] 'other-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

;; AVY
(setq avy-background t)
(setq avy-styles-alist '((avy-goto-char-2 . at-full)))
;(setq avy-highlight-first nil)
(set-face-attribute 'avy-lead-face nil :background "blue" :foreground "white")
(set-face-attribute 'avy-lead-face-0 nil :background "blue" :foreground "red")

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;;HIDE STUFF
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
