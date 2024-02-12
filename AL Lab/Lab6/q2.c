#include<stdio.h>

int opcount = 0;

void swap(int *a, int *b){
	opcount++;
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[],int low, int high){
	opcount++;
	int pivot = arr[high];
	int i=(low-1);
	for(int j=low;j<=high;j++){
		opcount++;
		if(arr[j]<pivot){
			i++;
			swap(&arr[i],&arr[j]);
		}
	}
	swap(&arr[i+1],&arr[high]);
	return (i+1);
}

void quickSort(int arr[], int low, int high){
	if(low<high){
		int pi=partition(arr,low,high);
		quickSort(arr,low,pi-1);
		quickSort(arr,pi+1,high);
	}
}

int main(){
	int arr[] = {3,17,15,2,5,4,8};
	int n=sizeof(arr)/sizeof(arr[0]);
	printf("Size of array: %d\n",n);
	quickSort(arr,0,n-1);
	printf("Sorted Array: ");
	for(int i=0;i<n;i++){
		printf("%d ",arr[i]);
	}
	printf("\nOpCount %d\n",opcount);
	return 0;
}

// Output
//Size of array: 7
// Sorted Array: 2 3 6 9 10 15 17 
// OpCount 29
// 