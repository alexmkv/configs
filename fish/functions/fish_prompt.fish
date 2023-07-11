
function fish_prompt --description 'Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                         and set_color $fish_color_cwd_root
                                                         or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus " [" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        printf '[%s]' (date "+%H:%M")
        echo -n (set_color $fish_color_cwd) $PWD
        set -l git_branch $(git symbolic-ref --short HEAD 2>/dev/null)
        if [ -n "$git_branch" ]
            set -l git_changes $(git status --short)
            if [ -n "$(git status --short)" ]
                echo -n (set_color $fish_color_error)
            end
            printf ' {%s}' $git_branch
        end
        echo -n (set_color normal)
        echo -n $pipestatus_string
        echo -n ' > '
    end
end
