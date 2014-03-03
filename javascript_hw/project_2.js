var total=0, previous = 0, current = 1;
for(i = 0; i < 4000000; i = previous ) {
    previous = current;
    current = i + current;

    if( current % 2 === 0 ) {
        total += current;
    }
}
console.log(total);