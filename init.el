
;; Set path to load custom emacs packages not managed by package manager (eg ampl-mode.el)
(setq load-path (cons "~/.emacs.d/packages-misc" load-path))


;; use pdf-tools instea of docView to view pdfs JH added 11/20/17
;;(pdf-tools-install)

;; JH added 11/20/17
;; DocView zoom hotkeys (for pdfs, etc)
;; (global-set-key [C-mouse-4] 'text-scale-increase)
;; (global-set-key [C-mouse-5] 'text-scale-decrease)
;; (global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
;; (global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)


;;Tell emacs to look in our emacs directory for extensions
(setq load-path (cons "~/emacs" load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tell emacs to look in our emacs directory for extensions
;; (setq load-path (cons "/usr/share/emacs/site-lisp" load-path))


;; SEE : http://stackoverflow.com/questions/13897125/emacs-translating-c-h-to-del-m-h-to-m-del
;; use control-h for delete backwards (kinesis BackSpace key)
(global-set-key "\C-h" 'delete-backward-char)

(setq dired-listing-switches "-alh")

(put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Starts the Emacs server
;;(server-start)
;;(require 'server)
;;(unless (server-running-p)
;;  (server-start))

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(setq ns-use-srgb-colorspace t)

;; TOGGLE WINDOW SPLIT FROM HORIZONTAL TO VERTICAL
;; http://www.emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	          (next-win-buffer (window-buffer (next-window)))
		       (this-win-edges (window-edges (selected-window)))
		            (next-win-edges (window-edges (next-window)))
			         (this-win-2nd (not (and (<= (car this-win-edges)
							      (car next-win-edges))
							      (<= (cadr this-win-edges)
								   (cadr next-win-edges)))))
				      (splitter
				             (if (= (car this-win-edges)
						         (car (window-edges (next-window))))
						   'split-window-horizontally
					       'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	    (funcall splitter)
	      (if this-win-2nd (other-window 1))
	        (set-window-buffer (selected-window) this-win-buffer)
		  (set-window-buffer (next-window) next-win-buffer)
		    (select-window first-win)
		      (if this-win-2nd (other-window 1))))))

;;(define-key ctl-x-4-map "t" 'toggle-window-split)
(global-set-key (kbd "C-x |") 'toggle-window-split) ;; changed hotkey 11/7/17


;; http://stackoverflow.com/questions/1249497/command-to-center-screen-horizontally-around-cursor-on-emacs
(defun my-horizontal-recenter ()
  "make the point horizontally centered in the window"
  (interactive)
  (let ((mid (/ (window-width) 2))
        (line-len (save-excursion (end-of-line) (current-column)))
        (cur (current-column)))
    (if (< mid cur)
        (set-window-hscroll (selected-window)
                            (- cur mid)))))
;;And the obvious binding (from obvio171) is:
(global-set-key (kbd "C-S-l") 'my-horizontal-recenter)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ECLIPSE INTEGRATION
;; (custom-set-variables
;;   '(eclim-eclipse-dirs '("~/Applications/eclipse"))
;;   '(eclim-executable "~/Applications/eclipse/eclim"))


;; (require 'eclim)
;; (global-eclim-mode)
;; ;; If you want to control eclimd from emacs, also add:
;; (require 'eclimd)

;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

;; ;; regular auto-complete initialization
;; (require 'auto-complete-config)
;; (ac-config-default)

;; ;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-eclim-config)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FOR USE WITH EMACS SERVER - NO NEED TO KILL-EMACS OR CLOSE EMACS WINDOW
;; (global-unset-key (kbd "C-x C-c"))
;; (global-unset-key (kbd "C-x C-z"))

;; http://www.emacswiki.org/emacs/MaximaMode
(add-to-list 'load-path "/usr/local/Cellar/maxima/5.33.0/share/maxima/5.33.0/emacs/")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)
(add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))


;; make bash aliases work in eshell
;; see : http://stackoverflow.com/questions/12224909/is-there-a-way-to-get-my-emacs-to-recognize-my-bash-aliases-and-custom-functions
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")

;; DELETED packages to reduce potential sources of emacs crashes:
;; bookmark+
;; concurrent
;; ctable
;; deferred
;; ecb
;; edbi
;; epc
;; icicles
;; scala-mode2
;; dash
;; popup
;; popwin


;; Give Unique Names to buffers - ie. if you have 2 files open with same name
;; http://stackoverflow.com/questions/2903426/display-path-of-file-in-status-bar
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)


;; SETTING ENVIRONMENT VARIABLES IN EMACS
;; see :http://www.bnikolic.co.uk/blog/emacs-environment-vars.html
;;(setenv "PATH" (concat "/home/an_user/bin:"
;;                (getenv "PATH")))

;; SET ENVIRONMENT VARIABLES IN EMACS TO BE SAME AS USER SHELL (mac-specific?)
;;(require 'exec-path-from-shell) ;; if not using the ELPA package
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))



(setq default-directory "/Users/jason/dev")

;;; Set location for external packages.
(add-to-list 'load-path "~/.emacs.d/lisp")
;; see : http://zmjones.com/mac-setup/
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EMACS CUSTOM CONFIGURATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; SEE : http://superuser.com/questions/685111/basic-setup-of-emacs-server-under-osx
;; To make Emacs.app open files in an existing frame instead of a new frame,
;; add (setq ns-pop-up-frames nil) to a configuration file like ~/.emacs.
(setq ns-pop-up-frames nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; USEFUL FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun copy-full-path-to-kill-ring ()
   "copy buffer's full path to kill ring"
   (interactive)
   (when buffer-file-name
     (kill-new (file-truename buffer-file-name))))

(defun dos2unix (buffer)
      "Automate M-% C-q C-m RET C-q C-j RET"
      (interactive "*b")
      (save-excursion
        (goto-char (point-min))
        (while (search-forward (string ?\C-m) nil t)
          (replace-match (string ?\C-j) nil t))))

;; Temporarily maximize one buffer, then return to prior window frame configuration
;;https://gist.github.com/mads379/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EMACS THEME;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'color-theme)
;;     (color-theme-initialize)
;;     (color-theme-blue-mood)

;; (defun zenburn-init ()
;;   (load-theme 'zenburn))
;; (add-hook 'after-init-hook 'zenburn-init)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HOTKEYS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [(control ?,)] (lambda () (interactive) (other-window -1)))
(global-set-key [(control ?.)] (lambda () (interactive) (other-window 1)))

;;
;;
;; FRAME SIZE WAS HERE
;;
;;

;;; TRAMP MODE SETTINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)
(setq tramp-default-method "ssh")

;; Disable auto save for all buffers. I manually disable auto-save
;; when I'm using tramp or sshfs and fuse. Might be better to just
;; eval this by hand rather than have it here. However, I'm typically
;; a compusive saver so I probably won't notice if it disabled.
;; http://www.emacswiki.org/emacs/AutoSave
(setq auto-save-default nil)
;; This helps speed. It might be the new default. Check by using
;; describe-variable. For a one-time test, you can also open a remote
;; dir as /scpc:dev/remote_dir/ and any files opened in that dir will
;; (apparently) be opened with the same method as the dir. Also fast
;; is scpx.
;; (setq tramp-default-method "scpc")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set truncate long lines as the default
(setq-default truncate-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ; wrap long lines in text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NO SPLASH SCEEN
(setq inhibit-splash-screen t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable the menu-bar in console mode..
(menu-bar-mode -1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; syntax highlighting
(global-font-lock-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXTERNAL COMMANDS
(setq latex-run-command "pdflatex")

(setq ispell-program-name "/usr/local/bin/ispell")
;; maybe try this one day : (setq ispell-program-name "/usr/local/bin/aspell")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fix ls for Dired on Mac
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

;; Selecting between visible buffers with arrow keys
;;(windmove-default-keybindings 'hyper)  ; etc.
;; If you wish to enable wrap-around, also add a line like:
;;(setq windmove-wrap-around t)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; As far as I know, I don't want emacs doing anything with version
;; control. I certaily don't want tramp running extra commands to
;; check on the version control status of files.
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; default shell ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq explicit-shell-file-name "/bin/bash")


;; CRONTAB MODE  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADD PACKAGE REPOSITORY
(require 'package)
;; (add-to-list 'package-archives
;;  '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; see : http://zmjones.com/mac-setup/
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)


;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
 ;;            '("marmalade" . "http://marmalade-repo.org/packages/") t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG-MODE RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; to enable export of org-mode documents
;; (require 'org-latex)
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))
;; (add-to-list 'org-export-latex-classes
;;              '("article"
;;                "\\documentclass{article}"
;;                ("\\section{%s}" . "\\section*{%s}")))

;; (setq org-latex-to-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open files when using Dired in other apps..
;; (defun open-in-external-app ()
;;   "Open the current file or dired marked files in external app.
;; Works in Microsoft Windows, Mac OS X, Linux."
;;   (interactive)
;;   (let ( doIt
;;          (myFileList
;;           (cond
;;            ((string-equal major-mode "dired-mode") (dired-get-marked-files))
;;            (t (list (buffer-file-name))) ) ) )

;;     (setq doIt (if (<= (length myFileList) 5)
;;                    t
;;                  (y-or-n-p "Open more than 5 files?") ) )

;;     (when doIt
;;       (cond
;;        ((string-equal system-type "windows-nt")
;;         (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
;;         )
;;        ((string-equal system-type "darwin")
;;         (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "open" fPath)) )  myFileList) )
;;        ((string-equal system-type "gnu/linux")
;;         (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath)) ) myFileList) ) ) ) ) )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAGIT-MODE RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IDO-MODE RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
(ido-mode 1)

(ido-everywhere t); use ido-mode everywhere, in buffers and for finding files
(setq ido-use-filename-at-point 'guess); for find-file-at-point
(setq ido-use-url-at-point t); look for URLs at point
(setq ffap-require-prefix t); get find-file-at-point with C-u C-x C-f


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIND RECENT FILES FAST;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 1000)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPY & PASTE MAC OSX
;; http://www.emacswiki.org/emacs-en/CopyAndPaste#toc9
;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIND RECENT FILES FAST;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; GOODIES below taken from: http://news.ycombinator.com/item?id=1654164

;; use this to start server for emacsclient
;(if (not (boundp 'server-process))
;    (server-start))

;; remote shell! Hooray!
;  (require 'ssh)
;  (add-hook 'ssh-mode-hook 'ssh-directory-tracking-mode)


;; integrate copy/paste with X
(setq x-select-enable-clipboard t)
    (if (functionp 'x-cut-buffer-or-selection-value)
        (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))

;;
(global-set-key (kbd "C-c k") 'browse-kill-ring)


;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)


;; Don't insert instructions in the *scratch* buffer
(setq initial-scratch-message nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAVE WINDOWS CONFIGURATION MODE
;; (require 'windows)
;; (win:startup-with-window)
;; (define-key ctl-x-map "C" 'see-you-again)


;; WINDOW CONFIGURATION SAVING - revive.el
;;
;; (autoload 'save-current-configuration "revive" "Save status" t)
;; (autoload 'resume "revive" "Resume Emacs" t)
;; (autoload 'wipe "revive" "Wipe Emacs" t)
;; ;;;	And define favorite keys to those functions.  Here is a sample.
;; (define-key ctl-x-map "S" 'save-current-configuration)
;; (define-key ctl-x-map "F" 'resume)
;; (define-key ctl-x-map "K" 'wipe)

;;
;;
;; Allow frame navigation with arrows
;; (require 'framemove)
;; (framemove-default-keybindings) ;; default prefix is Meta


;; save my session
;(desktop-save-mode 1)
;(setq history-length 250)
;    (add-to-list 'desktop-globals-to-save 'file-name-history)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PROGRAMMING LANGUAGE SPECIFIC CONFIGURATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Show matching parens (mixed style)
(show-paren-mode t)
(setq show-paren-delay 0.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTO-COMPLETE RELATED

;; (require 'auto-complete)
;; (global-auto-complete-mode t)

;; (setq ess-use-auto-complete t)

;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (unless (minibufferp (current-buffer))
;;     (auto-complete-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REINSTALL THIS FROM web when needed:
;;(require 'psvn)
;;(setq svn-status-default-diff-arguments '("--diff-cmd" "diff" "-x" "-wbBu"))


;; OCTAVE RELATED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (add-hook 'octave-mode-hook
;;           (lambda ()
;;             (abbrev-mode 1)
;;             (auto-fill-mode 1)
;;             (if (eq window-system 'x)
;;                 (font-lock-mode 1))))
;; (setq inferior-octave-startup-args '("--line-editing" "-i"))


;; C/C++ RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq c-default-style "linux"
      c-basic-offset 4)

;; c++ IDE mode
;; (global-ede-mode 1)
;; (require 'semantic/sb)
;; (semantic-mode 1)

;; (require 'cc-mode)
;; (setq-default c-basic-offset 4 c-default-style "linux")
;; (setq-default tab-width 4 indent-tabs-mode t)
;; (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; Java Mode (Eclipse-like);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eclipse-java-style is the same as the "java" style (copied from
;; cc-styles.el) with the addition of (arglist-cont-nonempty . ++) to
;; c-offsets-alist to make it more like default Eclipse formatting -- function
;; arguments starting on a new line are indented by 8 characters
;; (++ = 2 x normal offset) rather than lined up with the arguments on the
;; previous line
;; (defconst eclipse-java-style
;;   '((c-basic-offset . 4)
;;     (c-comment-only-line-offset . (0 . 0))
;;     ;; the following preserves Javadoc starter lines
;;     (c-offsets-alist . ((inline-open . 0)
;;                         (topmost-intro-cont    . +)
;;                         (statement-block-intro . +)
;;                         (knr-argdecl-intro     . 5)
;;                         (substatement-open     . +)
;;                         (substatement-label    . +)
;;                         (label                 . +)
;;                         (statement-case-open   . +)
;;                         (statement-cont        . +)
;;                         (arglist-intro  . c-lineup-arglist-intro-after-paren)
;;                         (arglist-close  . c-lineup-arglist)
;;                         (access-label   . 0)
;;                         (inher-cont     . c-lineup-java-inher)
;;                         (func-decl-cont . c-lineup-java-throws)
;;                         (arglist-cont-nonempty . ++)
;;                         )))
;;   "Eclipse Java Programming Style")
;; (c-add-style "ECLIPSE" eclipse-java-style)
;; (customize-set-variable 'c-default-style (quote ((java-mode . "eclipse") (awk-mode . "awk") (other . "gnu"))))


;; DATABASE RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set MySQL as default product
(eval-after-load "sql"
  '(progn
     (sql-set-product 'mysql)
     ;; any other config specific to sql
  ))

;;Put this file into your load-path and the following into your ~/.emacs:
;; (require 'sql-completion)
;; (setq sql-interactive-mode-hook
;;       (lambda ()
;;         (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
;;         (sql-mysql-completion-init)))
;;To save time of building database schema, add sql-mysql-schema to
;;desktop-globals-to-save:
;;(require 'desktop)
;;(add-to-list 'desktop-globals-to-save 'sql-mysql-schema)

 (defun my-sql-save-history-hook ()
    (let ((lval 'sql-input-ring-file-name)
          (rval 'sql-product))
      (if (symbol-value rval)
          (let ((filename
                 (concat "~/.emacs.d/sql/"
                         (symbol-name (symbol-value rval))
                         "-history.sql")))
            (set (make-local-variable lval) filename))
        (error
         (format "SQL history will not be saved because %s is nil"
                 (symbol-name rval))))))

  (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;; SCALA RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (unless (package-installed-p 'scala-mode2)
;; (package-refresh-contents) (package-install 'scala-mode2))


;; ADO-MODE (STATA)  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INSTALL THIS WHEN NEEDED - may interfere with ESS
;;(setq load-path (cons "/Applications/Emacs.app/Contents/Resources/site-lisp/ado-mode/lisp" load-path))
;;(require 'ado-mode)
;; instead of ess-mode

;; JAGS MODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (bugs too??)
;;(require 'ess-jags-d)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AMPL RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ampl mode (GNU Math Prog too)
(setq auto-mode-alist
      (cons '("\.mod$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\.run$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\.dat$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\.ampl$" . ampl-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("ampl" . ampl-mode)
            interpreter-mode-alist))

(load "ampl-mode")

;; Enable syntax coloring
(add-hook 'ampl-mode-hook 'turn-on-font-lock)

;; If you find parenthesis matching a nuisance, turn it off by
;; removing the leading semi-colons on the following lines:

;(setq ampl-auto-close-parenthesis nil)
;(setq ampl-auto-close-brackets nil)
;(setq ampl-auto-close-curlies nil)
;(setq ampl-auto-close-double-quote nil)
;(setq ampl-auto-close-single-quote nil)

(defun ampl-comment-dwim ()
  "Comment or uncomment the current line or text selection."
  (interactive)

  ;; If there's no text selection, comment or uncomment the line
  ;; depending whether the WHOLE line is a comment. If there is a text
  ;; selection, using the first line to determine whether to
  ;; comment/uncomment.
  (let (p1 p2)
    (if (region-active-p)
	(save-excursion
	  (setq p1 (region-beginning) p2 (region-end))
	  (goto-char p1)
	  (if (wholeLineIsCmt-p)
	      (ampl-uncomment-region p1 p2)
	    (ampl-comment-region p1 p2)
	    ))
      (progn
	(if (wholeLineIsCmt-p)
	    (ampl-uncomment-current-line)
	  (ampl-comment-current-line)
	  )) )))

(defun wholeLineIsCmt-p ()
  (save-excursion
    (beginning-of-line 1)
    (looking-at "[ \t]*#")
    ))

(defun ampl-comment-current-line ()
  (interactive)
  (beginning-of-line 1)
  (insert "# ")
  )

(defun ampl-uncomment-current-line ()
  "Remove “#” (if any) in the beginning of current line."
  (interactive)
  (when (wholeLineIsCmt-p)
    (beginning-of-line 1)
    (search-forward "# ")
    (delete-backward-char 2)
    ))

(defun ampl-comment-region (p1 p2)
  "Add “# ” to the beginning of each line of selected text."
  (interactive "r")
  (let ((deactivate-mark nil))
    (save-excursion
      (goto-char p2)
      (while (>= (point) p1)
	(ampl-comment-current-line)
	(previous-line)
	))))

(defun ampl-uncomment-region (p1 p2)
  "Remove “# ” (if any) in the beginning of each line of selected text."
  (interactive "r")
  (let ((deactivate-mark nil))
    (save-excursion
      (goto-char p2)
      (while (>= (point) p1)
	(ampl-uncomment-current-line)
	(previous-line) )) ))

;; USE FOLLOWING IF YOU WANT REGULAR COMMENT-DWIM BEHAVIOR INSTEAD
;; ;; the command to comment/uncomment text
;; (defun ampl-comment-dwim (arg)
;; "Comment or uncomment current line or region in a smart way.
;; For detail, see `comment-dwim'."
;; (interactive "*P")
;; (require 'newcomment)
;; (let ((deactivate-mark nil) (comment-start "#") (comment-end ""))
;; (comment-dwim arg)))

;; modify the keymap
(define-key ampl-mode-map [remap comment-dwim] 'ampl-comment-dwim)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END OF AMPL RELATED  SECTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHAT DID THIS DO ?????????????????
;;(eval-after-load "tex-mode" `(fset ‘tex-font-lock-suscript `ignore))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESS / R RELATED  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/")
;; (load "ess-site")

;; (require 'ess-site)

;; jh 1/11/2017 NO longer freeze emacs while evaluating region
(setq ess-eval-visibly 'nowait)

;; ;; jh 4/5/2014 comment this out:
;; (setq ess-tab-complete-in-script t)

;; Turn off emacs debug mode
(setq ess-use-tracebug nil)


;; ;; JH: Useful ESS SHORTCUTS
;; from: http://stackoverflow.com/questions/2901198/useful-keyboard-shortcuts-and-tips-for-ess-r
;; C-tab to switch between the R command line and the file (similar to josh answer, but much faster):
(global-set-key [C-tab] 'other-window)

;; Control and up/down arrow keys to search history with matching what you've already typed:

(define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)

(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;; JH: 'Make Shift-Enter Do a Lot in ESS
;; taken from: http://www.kieranhealy.org/blog/archives/2009/10/12/make-shift-enter-do-a-lot-in-ess/
;; Adapted with one minor change from Felipe Salazar at
;; http://www.emacswiki.org/emacs/EmacsSpeaksStatistics
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1 nil t))
        (R)
        (set-window-buffer w2 "*R*")
        (set-window-buffer w1 w1name))))

(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))
(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))
(add-hook 'Rnw-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))

;; Sweave, latex makefile
(global-set-key (kbd "C-c m")
		(lambda ()
		  (save-buffer)
		  (interactive)
		  (shell-command (concat "make"))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; FROM: https://svn.fsg.ulaval.ca/svn-pub/vgoulet/emacs-modified/macos/tags/Emacs-24.3-modified-4/site-start.el
;; ;; Following the "source is real" philosophy put forward by ESS, one
;; ;; should not save the workspace at the end of an R session. Hence,
;; ;; the option is disabled here.
;; (setq-default inferior-R-args "--no-save ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END OF ESS RELATED  SECTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTO-GENERATED SECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#3f3f3f" "#ea3838" "#7fb07f" "#fe8b04" "#62b6ea" "#e353b9" "#1fb3b3" "#d5d2be"])
 '(bmkp-last-as-first-bookmark-file "/Users/jason/.emacs.d/bookmarks")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (meacupla)))
 '(custom-safe-themes
   (quote
    ("12b7ed9b0e990f6d41827c343467d2a6c464094cbcc6d0844df32837b50655f9" "71ecffba18621354a1be303687f33b84788e13f40141580fa81e7840752d31bf" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "316d29f8cd6ca980bf2e3f1c44d3a64c1a20ac5f825a167f76e5c619b4e92ff4" "77c65d672b375c1e07383a9a22c9f9fc1dec34c8774fe8e5b21e76dca06d3b09" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a444b2e10bedc64e4c7f312a737271f9a2f2542c67caa13b04d525196562bf38" "108b3724e0d684027c713703f663358779cc6544075bc8fd16ae71470497304f" "2e5705ad7ee6cfd6ab5ce81e711c526ac22abed90b852ffaf0b316aa7864b11f" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8fd393097ac6eabfcb172f656d781866beec05f27920a0691e8772aa2cdc7132" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "cd70962b469931807533f5ab78293e901253f5eeb133a46c2965359f23bfb2ea" "a53714de04cd4fdb92ed711ae479f6a1d7d5f093880bfd161467c3f589725453" "31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(ess-describe-at-point-method (quote tooltip))
 '(ess-roxy-str "##'")
 '(ess-swv-processor (quote knitr))
 '(fci-rule-color "#222222")
 '(global-auto-complete-mode nil)
 '(gnus-logo-colors (quote ("#4c8383" "#bababa")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(grep-find-ignored-files
   (quote
    (".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.RData" "*.Rdata" "*.jar" "*.class" "*.db")))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(imaxima-image-type (quote jpeg))
 '(inferior-octave-program "/usr/local/bin/octave")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (magit exec-path-from-shell pdf-tools ess zenburn-theme yaml-mode use-package solarized-theme polymode moe-theme meacupla-theme markdown-mode json-snatcher json-reformat helm framemove flatland-theme ensime dirtree cyberpunk-theme color-theme-solarized color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-theme-heroku bookmark+ auto-complete alect-themes)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(send-mail-function nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(sql-connection-alist
   (quote
    (("AlgoTraderExt"
      (sql-product
       (quote mysql))
      (sql-user "algouser")
      (sql-password "algopwd")
      (sql-server "localhost")
      (sql-database "AlgoTraderExt")))))
 '(sql-database "AlgoTraderExt")
 '(sql-mysql-program "/usr/local/bin/mysql")
 '(sql-sybase-login-params (quote (user password server)))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background "#222222")
 '(vc-annotate-color-map
   (quote
    ((20 . "#fa5151")
     (40 . "#ea3838")
     (60 . "#f8ffa0")
     (80 . "#e8e815")
     (100 . "#fe8b04")
     (120 . "#e5c900")
     (140 . "#32cd32")
     (160 . "#8ce096")
     (180 . "#7fb07f")
     (200 . "#3cb370")
     (220 . "#099709")
     (240 . "#2fdbde")
     (260 . "#1fb3b3")
     (280 . "#8cf1f1")
     (300 . "#94bff3")
     (320 . "#62b6ea")
     (340 . "#00aff5")
     (360 . "#e353b9"))))
 '(vc-annotate-very-old-color "#e353b9")
 '(warning-suppress-types (quote ((\(undo\ discard-info\)))))
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))



(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BOOKMARKS
(require 'bookmark+ nil t)
(setq bookmark-version-control t)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
;;(setq initial-buffer-choice "*Bookmark List*")

(put 'downcase-region 'disabled nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; POLYMODE - ESS & RMARKDOWN 
;;; Markdown mode
;; see : http://simon.bonners.ca/bonner-lab/wpblog/?p=142
;; see : http://johnstantongeddes.org/open%20science/2014/03/26/Rmd-polymode.html
;; see : http://stackoverflow.com/questions/16172345/how-can-i-use-emacs-ess-mode-with-r-markdown

;;(autoload 'r-mode "ess-site" "(Autoload)" t)

(require 'poly-R)
(require 'poly-markdown)

;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

;;; R modes
;;(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
;;(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))


;;; YAML-MODE
 (add-hook 'yaml-mode-hook
        (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


(use-package ensime
  :pin melpa-stable)


;; SET EMACS PATH FROM SHELL 
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "LC_ALL") 
(exec-path-from-shell-copy-env "LANG")
(exec-path-from-shell-copy-env "LC_CTYPE")
(exec-path-from-shell-copy-env "LC_COLLATE")
(exec-path-from-shell-copy-env "LC_TIME")
(exec-path-from-shell-copy-env "LC_MESSAGES")
(exec-path-from-shell-copy-env "LC_MONETARY")






 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FRAME SIZE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   (if window-system
;;   (progn
;;     ;; use 120 char wide window for largeish displays
;;     ;; and smaller 80 column windows for smaller displays
;;     ;; pick whatever numbers make sense for you
;;     (if (> (x-display-pixel-width) 1280)
;;            (add-to-list 'default-frame-alist (cons 'width 120))
;;            (add-to-list 'default-frame-alist (cons 'width 100)))
;;     ;; for the height, subtract a couple hundred pixels
;;     ;; from the screen height (for panels, menubars and
;;     ;; whatnot), then divide by the height of a char to
;;     ;; get the height we want
;;     (add-to-list 'default-frame-alist
;;          (cons 'height (/ (- (x-display-pixel-height) 250)
;;                              (frame-char-height)))))))

;; (set-frame-size-according-to-resolution)


(setq initial-frame-alist '((left . 500) (top . 20) (width . 270) (height . 100)))



(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
