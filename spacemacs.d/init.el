(setq-default dotspacemacs-themes '(zenburn))
(setq dotspacemacs-additional-packages '(gradle-mode))
(setq-default dotspacemacs-configuration-layers '(
      csv
      auto-completion
      (c-c++ :variables c-c++-enable-clang-support t c-c++-default-mode-for-headers 'c++-mode)
      clojure
      docker
      elixir
      emacs-lisp
      ess
      git
      go
      haskell
      html
      (java :variables java-backend 'meghanda)
      javascript
      groovy
      ipython-notebook
      latex
      lua
      markdown
      python
      ruby
      rust
      scala
      shell
      shell-scripts
      yaml
))
