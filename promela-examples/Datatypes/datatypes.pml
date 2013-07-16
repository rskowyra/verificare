#define size 10

/*Set of ints*/
chan i_set = [size] of {int};

/*Array of ints*/
int i_ar[size];

/*Array of sets*/
chan ar_set[size] = [size] of {int}

/*Set of arrays*/
typedef array{
	int i_ar[size];
}
chan set_ar = [size] of {array};

/*Array of arrays of arrays*/
typedef d{
	int c[size]
}

typedef dd{
	d b[size];
}

typedef ddd{
	dd a[size];
}

init{
/*Set of ints*/
i_set!10; /*Insertion*/
i_set??[10]; /*Containment*/
i_set?10; /*Removal*/

/*Array of ints*/
i_ar[0]=10; /*Assignment*/
i_ar[0] == 10; /*Value testing

/*Array of sets*/
ar_set[0]=i_set; /*Set Assignment*/
ar_set[0]!10; /*Set element assignment*/
ar_set[0]??[10]; /*Set containment checkb*/
ar_set[0]??10; /*Set element removal*/

/*Set of arrays*/
array my_array, my_array2; /*Element declaration*/
set_ar!my_array; /*Element insertion*/
set_ar??my_array2;

/*Three-Dimensional Array (Requires Dim-1 typedefs)*/
dd array_3d[size];
array_3d[0].b[0].c[0]=1;


}
