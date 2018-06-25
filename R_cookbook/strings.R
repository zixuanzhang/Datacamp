######### strings #########

### two common ways of creating strings

## use paste()
a <- "apple"
b <- "banana"
paste(a,b)
paste(a,b,sep="")
paste0(a,b)
paste(a,b,sep=" ")
paste(a,b, sep=", ")

# work with vector
d <- c("fig", "grapefruit", "honeydew")
paste(d, collapse = ", ") # put elements together
paste(a,d) # a is a scalar, d is a vector, it returns a vector
paste(a,d, sep="-", collapse = ", ")

## use sprintf()

a <- "string"
sprintf("this is where a %s goes",a) # use %s to substitute in a string

x <- 8
sprintf("Regular:%d", x) # use %d for integer

sprintf("Leading spaces: %4d",x) # put 4 spaces in front
sprintf("leading zeros: %04d",x) # put 4 zeros in front

# common usage
sprintf("%f", pi)         # "3.141593"
sprintf("%.3f", pi)       # "3.142"
sprintf("%1.0f", pi)      # "3"
sprintf("%5.1f", pi)      # "  3.1"
sprintf("%05.1f", pi)     # "003.1"
sprintf("%+f", pi)        # "+3.141593"
sprintf("% f", pi)        # " 3.141593"
sprintf("%-10f", pi)      # "3.141593  "   (left justified)
sprintf("%e", pi)         #"3.141593e+00"
sprintf("%E", pi)         # "3.141593E+00"
sprintf("%g", pi)         # "3.14159"
sprintf("%g",   1e6 * pi) # "3.14159e+06"  (exponential)
sprintf("%.9g", 1e6 * pi) # "3141592.65"   ("fixed")
sprintf("%G", 1e-6 * pi)  # "3.14159E-06"

# substitute in multiple string
sprintf("substitute in multiple strings: %s %s",x,"string2")

# to print a single percent sign, use double %
sprintf("A single percent sign: %%") 
