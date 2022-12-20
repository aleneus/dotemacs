# mirror the melpa emacs archive

rsync -avz --delete --progress rsync://melpa.org/packages/ ~/emacs-pkgs/melpa/.

# elpa

rsync -avz --delete --progress elpa.gnu.org::elpa/. ~/emacs-pkgs/elpa
