dissect() {
    . /opt/dissect/bin/activate

    local dissect_target_dir=$(dirname $(python3 -c "import dissect.target; print(dissect.target.__file__)"))
    local autocompletion_dir="${dissect_target_dir}/data/autocompletion"

    if [[ -d "$autocompletion_dir" ]]; then
        for file in $autocompletion_dir/*;
        do
            source $file
        done
    fi
}
