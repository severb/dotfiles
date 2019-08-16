#!/usr/bin/env zsh

# TODO: better virtualenv support

###############################################################################
# VCS settings
autoload -Uz vcs_info
autoload -U add-zsh-hook

zstyle ':vcs_info:*' enable git hg

# This can be slow
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# Set formats:
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
FMT_BRANCH="%u%c%F{blue}=<<%b%f "
FMT_BRANCH_EXTRA="%F{red}+++%f %u%c%F{blue}=<<%b%f "
FMT_ACTION="%F{magenta}!!%a%f "
FMT_UNSTAGED="%F{yellow}***%f "
FMT_STAGED="%F{green}===%f "

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

run_vcs_info() {
	if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
		zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH}"
	} else {
		zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH_EXTRA}"
	}
	vcs_info 'prompt'
}
add-zsh-hook precmd run_vcs_info


###############################################################################
# PROMPT
setopt prompt_subst
PROMPT='${vcs_info_msg_0_}%B%1//>%b '
RPROMPT='%~ %n@%F{red}%M%f ?=%? ::%j %T'
