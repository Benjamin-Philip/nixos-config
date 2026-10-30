;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Benjamin Philip"
      user-mail-address "benjamin.philip495@gmail.com")

(setq mail-user-agent 'notmuch-user-agent
      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program (executable-find "gmi")
      message-sendmail-extra-arguments '("send" "--quiet" "-C" "~/Maildir/personal"))

(setq org-msg-startup "hidestars indent inlineimages"
      org-msg-default-alternatives '((new . (text html))
                                     (reply-to-html . (text html))
                                     (reply-to-txt . (text)))
      org-msg-convert-citation t
      org-msg-signature "\n-- bp\n")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Emacs needs a POSIX shell. Use bash internally and fish for terminals:
(setq shell-file-name (executable-find "bash"))
(let ((fish (executable-find "bash")))
  (setq vterm-shell fish)
  (setq explicit-shell-file-name fish))

(set-fontset-font "fontset-default" 'malayalam "Noto Sans Malayalam")

(setq company-show-numbers t)

(use-package! eglot
  :ensure nil

  :config  (setf (alist-get '(elixir-mode elixir-ts-mode heex-ts-mode)
                            eglot-server-programs
                            nil nil #'equal)
                 (eglot-alternatives '(("expert" "--stdio")))))


(add-hook 'code-review-mode-hook
          (lambda ()
            ;; include *Code-Review* buffer into current workspace
            (persp-add-buffer (current-buffer))))
(with-eval-after-load 'code-review (require 'ghub-legacy))

;; epg
(after! plstore (add-to-list 'plstore-encrypt-to "A590EA9C"))
(setq epg-pinentry-mode 'loopback)

(defun ben/org-dir-file (file)
  (file-name-concat org-directory file))

(use-package! org-gcal
  :init
  ;; TODO: replace with sops-nix
  (load! "google-oauth-secret.el" org-directory)
  ;; org-gcal is async with deferred, so we need to set client details before
  ;; load to prevent race conditions
  (setq org-gcal-client-id ben/google-oauth-client-id
        org-gcal-client-secret ben/google-oauth-client-secret)
  :config
  (setq org-gcal-fetch-file-alist
        `((,user-mail-address . ,(ben/org-dir-file "primary.org"))
          ("f38d35fac3b4f7c73be34204fac9caaf07aba6dd5f8a5a7cba6df8a8fb5ad96f@group.calendar.google.com"
           . ,(ben/org-dir-file "college.org")))))

(use-package! org-todoist
  :init
  ;; TODO: replace with sops-nix
  (load! "todoist-api-token.el" org-directory)
  ;; required to handle differences between org and todoist
  ;; see org-todoist readme
  (add-to-list 'safe-local-variable-values '(org-list-indent-offset . 2))

  :config
  (setq org-todoist-api-token ben/todoist-api-token
        org-todoist-deleted-keyword "KILL")
  (org-todoist-background-sync))

(after! org
  (setq org-icalendar-timezone "Asia/Kolkata"
        org-refile-use-outline-path 'full-file-path
        ;; Match todoist's 4 priority structure
        org-lowest-priority ?D
        org-default-priority ?D
        org-priority-faces
        '((?A . error) (?B . warning) (?C . success) (?D . shadow))))

(after! citar (setopt citar-bibliography '("~/Documents/bibliography.bib")))

;; org roam ui

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; ai

(use-package gptel
  :init
  (gptel-make-ollama "Ollama"
    :host "localhost:11434"
    :stream t
    :models '(qwen2.5-coder:1.5b-base qwen3.5:9b deepseek-r1:7b phi4-mini))
  (gptel-make-gh-copilot "Copilot"))

;; Add ollama qwen2.5-coder:1.5b-base to gptel

(use-package minuet
  :init
  (bind-keys :prefix-map minuet-map :prefix "C-c j")
  :bind
  (
   :map minuet-map
   ;; keymap to invoke minuet
   ("y" . #'minuet-complete-with-minibuffer)
   ("i" . #'minuet-show-suggestion)
   ("c" . #'minuet-configure-provider)

   :map minuet-active-mode-map
   ;; These keymaps activate only when a minuet suggestion is displayed in the current buffer
   ("M-p" . #'minuet-previous-suggestion) ;; invoke completion or cycle to next completion
   ("M-n" . #'minuet-next-suggestion) ;; invoke completion or cycle to previous completion
   ("M-A" . #'minuet-accept-suggestion) ;; accept whole completion
   ;; Accept the first line of completion, or N lines with a numeric-prefix:
   ;; e.g. C-u 2 M-a will accepts 2 lines of completion.
   ("M-a" . #'minuet-accept-suggestion-line)
   ;; Accept the first word of completion, or N words with a numeric-prefix:
   ;; e.g. C-u 2 M-w will accepts 2 words of completion.
   ("M-w" . #'minuet-accept-suggestion-word)
   ("M-e" . #'minuet-dismiss-suggestion))

  :config
  (setq minuet-provider 'openai-fim-compatible)
  (setq minuet-n-completions 1) ; recommended for Local LLM for resource saving
  ;; I recommend beginning with a small context window size and incrementally
  ;; expanding it, depending on your local computing power. A context window
  ;; of 512, serves as an good starting point to estimate your computing
  ;; power. Once you have a reliable estimate of your local computing power,
  ;; you should adjust the context window to a larger value.
  (setq minuet-context-window 512)
  (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:11434/v1/completions")
  ;; an arbitrary non-null environment variable as placeholder.
  ;; For Windows users, TERM may not be present in environment variables.
  ;; Consider using APPDATA instead.
  (plist-put minuet-openai-fim-compatible-options :name "Ollama")
  (plist-put minuet-openai-fim-compatible-options :api-key "TERM")
  (plist-put minuet-openai-fim-compatible-options :model "qwen2.5-coder:1.5b-base")

  (minuet-set-optional-options minuet-openai-fim-compatible-options :max_tokens 56))
