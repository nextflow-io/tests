echo true 

process alpha {
    /
    echo alpha cpus: ${task.cpus}
    echo alpha queue: ${task.queue} 
    /
}

process beta {
    label 'small'

    /
    echo beta cpus: ${task.cpus}
    echo beta queue: ${task.queue} 
    /
}

process delta {
    label 'big'

    /
    echo delta cpus: ${task.cpus}
    echo delta queue: ${task.queue} 
    /
} 

process gamma {
    label 'big'
    cpus 4 
    queue 'foo'

    /
    echo gamma cpus: ${task.cpus}
    echo gamma queue: ${task.queue} 
    /
}