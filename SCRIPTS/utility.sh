
# define function to confirm bowtie2 database exists
check_bowtie2_index() {
    local prefix=$1
    local missing=0

    for i in 1 2 3 4; do
        [[ -f "${HOST_DATABASE}.${i}.bt2" ]] || missing=1
    done

    for i in 1 2; do    
        [[ -f "${HOST_DATABASE}.rev.${i}.bt2" ]] || missing=1    
    done

    if [[ $missing -eq 1 ]]; then    
        echo "Missing Bowtie2 index files for prefix: $HOST_DATABASE" >&2
        return 1    
    else    
        echo "Host Bowtie2 index is valid: $HOST_DATABASE"
        return 0    
    fi
}
