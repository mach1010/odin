console.log("begin");

function isPrime(n) {
    if( n == 1 || n == 2 || n == 3 || n == 5 ) {return true;}
    if( n % 2 === 0 ) {return false;}
    if( n % 3 === 0 ) {return false;}
    if( n % 5 === 0 ) {return false;}
    
    var square_root = Math.sqrt(n);
    if( n % square_root === 0 ) {return false;}
    
    for( i = 3; i < square_root; i+= 2) {
        if( n % i === 0 ) {return false;}
    }
    return true;
}

function find_greatest_prime(n) {
    var greatest_prime = 0;
    for( j = 3; j < n; j += 2) {

        if( n % j === 0 && isPrime(j) ) {greatest_prime = j;}
    }
    console.log("greatest prime is: " + greatest_prime);
}

find_greatest_prime(99999);