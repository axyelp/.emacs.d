;; -*- mode: emacs-lisp -*-
;;; text-mode-settings.el --- settings and customisations for `text-mode'.

;;; Code:

;; plain text footnotes in non-org-mode buffers
(defadvice org-footnote-action
  (around org-footnote-action-plain-or-fn (&optional SPECIAL))
  "Check if in `org-mode', if not use plain footnote style."
  (if (not (eq major-mode 'org-mode))
      (let ((org-footnote-auto-label 'plain))
	ad-do-it)
    ad-do-it))
(ad-activate 'org-footnote-action)
(global-set-key (kbd "C-c f") 'org-footnote-action)

;; text-mode hook
(defun sa-text-mode-hook()
  "My hook for modes which are like `text-mode'."
  ;; wrap long lines (if the window size is small)
  ;; (toggle-truncate-lines t)
  (unless (or (eq major-mode 'org-mode) (eq major-mode 'latex-mode))
    ;; turn on orgtbl minor mode
    (turn-on-orgtbl)
    ;; turn on enhanced orgstruct minor mode
    (turn-on-orgstruct++)
    ;; line folding w/o actually folding it
    (visual-line-mode t)
    ;; text mode abbreviations
    (setq local-abbrev-table text-mode-abbrev-table)
    ))
(add-hook 'text-mode-hook 'sa-text-mode-hook)
;; (add-hook 'muse-mode-hook 'sa-text-mode-hook)

;;; text-mode-settings.el ends here