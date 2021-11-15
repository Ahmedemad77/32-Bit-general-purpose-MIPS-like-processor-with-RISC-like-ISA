#include <string.h>
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>


int arrFindIndex(char* array[], char *text, int size){
    int x = -1;

    for(int i = 0; i < size; i++){
        //printf("%s\n%s", array[i], text);
        //printf("%s\n", array[1]);
        if(!strcmp(array[i], text)){
            x = i;
            break;
        }

    }

    return x;
}

// Takes the string and the char want to count
int countChar(char *input, char x){
    int i, count = 0;

     for(i=0;input[i];i++){
        if(input[i] == ';'){
            break;
        }
    	if(input[i]== x && input[i - 1] != x)
          count++;
 	}

 	return (count + 1);
}

char** str_split(char *input) {
    //char input[] = "This is an text HAHAH";
    int i, arraySize = 0, strSize = 80;

    // Here I am counting the number of the words in th string


 	arraySize = countChar(input, ' ');

 	//printf("%i", arraySize);

    //char result[sizeof(count) + 1][10] = {};
    char **result = malloc (sizeof (char *) * arraySize);

    if (!result) return NULL;
      for (i = 0; i < arraySize; i++) {
        result[i] = malloc (strSize+1);
        if (!result[i]) {
          free (result);
          return NULL;
        }
      }

    char *token = strtok(input, " ");


    // Here I am copying each word into array
    i = 0;
    while(token){
        strncpy(result[i], token, strSize);

        i++;
        token = strtok(NULL, " ");

    }

    return result;

}


int toBinary(int number){
    int i=1, binary = 0, rem;

    while(number){
        rem = number%2;
        number/=2;
        binary += rem * i;
        i *= 10;
    }
    return binary;
}

// Convert int to binary and extend it to n bits
char* extend(int x, int bits){
    int rem = 0;
    //char buffer[16], word[16] = "0";
    char word[32] = "0";
    char* buffer = malloc (5 * sizeof (char *));
    itoa(x,buffer,2);
    //printf("%s\n", buffer);

    rem = bits - strlen(buffer);
    if(rem <= 0) {
        return buffer;
    } else {
        for (int i = 0; i < rem; i++){ word[i] = '0';}

        strrev(buffer);
        strcat(buffer, word);
        strrev(buffer);
        return buffer;
    }
}

void swap(char **str1_ptr, char **str2_ptr)
{
  char *temp = *str1_ptr;
  *str1_ptr = *str2_ptr;
  *str2_ptr = temp;
}

int main()
{

    //Registers
    char* reg[] = {"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"};

    // R-Type instructions that has function
    char* instructionsRFunc[] = {"add", "sub", "and", "or", "nor", "xor", "sll", "srl", "dec", "inc", "cmp"};
    char func[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1};

    // R-Type instructions with no function
    char* instructionsR[] = {"jr", "pop", "push", "in", "out", "mov"};
    char opRType[] = {13, 19, 20, 21, 22, 25};

    // I-Type instructions
    char* instructionsI[] = {"addi", "andi", "cmpi", "ori", "beq", "bg", "bne", "bs", "lw", "sw", "inmem", "movi"};
    char opIType[] = {2, 3, 4, 5, 6, 7, 8, 9, 16, 17, 18, 26};


    // Read the Code file
    FILE* file = fopen("assembly.txt", "r");

    if(!file){
        printf("No file found");
        return EXIT_FAILURE;
    }

    // The current line we are dealing with
    char line[128];

    // Create the file to write in
    FILE* code = fopen("code.txt", "w");

    // Go through each line
    while(fgets(line, sizeof line, file) != NULL){

        // Here I am counting The number of a char in a string so that i can loop over the string
        int num = countChar(line, ' ');
        // Here I am splitting the current ling with ( space )
        char** inst = str_split(line);

        // The size of Register Array
        int regArrSize = sizeof(reg) / sizeof(reg[0]);

        // The size of R Type instructions that has function
        int instRFuncArrSize = sizeof(instructionsRFunc) / sizeof(instructionsRFunc[0]);
        // Find the index of current R Type instruction
        int indexRFunc = arrFindIndex(instructionsRFunc, inst[0], instRFuncArrSize);

        // The size of R Type instructions with no function
        int instRArrSize = sizeof(instructionsR) / sizeof(instructionsR[0]);
        // Find the index of current R Type instruction
        int indexR = arrFindIndex(instructionsR, inst[0], instRArrSize);

        // The size of R Type instructions with no function
        int instIArrSize = sizeof(instructionsI) / sizeof(instructionsI[0]);
        // Find the index of current R Type instruction
        int indexI = arrFindIndex(instructionsI, inst[0], instIArrSize);

        // if indexRFunc > -1 it means that the inst is R-Type
        if(indexRFunc != -1){
            //fputs(op[index], code);
            //fprintf(code, "%s", op[index]);

            printf("\'%s\'\tis R-Type and its Function is \'%s\'\n", inst[0], extend(func[indexRFunc], 6));

            if(!strcmp(inst[0], "cmp")){
                fprintf(code, "%s", "000001");
            } else {
                fprintf(code, "%s", "000000");
            }

            // I Get =>     op rd rs rt
            // I Want =>    op rs rt rd sa fn

            // rs rd rt
            swap(inst[1], inst[2]);
            // rs rt rd
            swap(inst[2], inst[3]);


            //from 1 because i have already wrote the opcode
            for(int i = 1; i < num; i++) {
                // Last 2 chars of all inst will be ;\n so i remove them
                inst[i] = strtok(inst[i], ";\n");

                // Find the index of current R Type instruction
                int regIndex = arrFindIndex(reg, inst[i], regArrSize);

                // This means that inst[i] is not reg so it may be an integer
                if(regIndex == -1) {
                    int value = atoi(inst[i]);
                    //printf("\'%s\' not found\n", inst[i]);
                    fprintf(code, "%s", extend(value, 5));
                } else {
                    fprintf(code, "%s", extend(regIndex, 5));
                }

            }

            // Print the function
            fprintf(code, "%s\n", extend(func[indexRFunc], 6));

        } else if(indexR != -1){
            printf("\'%s\'\tis R-Type with no Function\n", inst[0]);

            // Print Op-Code
            fprintf(code, "%s", extend(opRType[indexR], 6));

            // rs rd
            swap(inst[1], inst[2]);

            //from 1 because i have already wrote the opcode
            for(int i = 1; i < num; i++) {
                // Last 2 chars of all inst will be ;\n so i remove them
                inst[i] = strtok(inst[i], ";\n");

                // Find the index of current register
                int regIndex = arrFindIndex(reg, inst[i], regArrSize);
                // This means that inst[i] is not reg so it may be an integer
                if(regIndex == -1) {
                    int value = atoi(inst[i]);
                    //printf("\'%s\' not found\n", inst[i]);
                    fprintf(code, "%s", extend(value, 5));
                } else {
                    fprintf(code, "%s", extend(regIndex, 5));
                }

            }

            // 6 => instead of the function
            // (5-num) => The remainder places
            // *6 => 5 bits for each place
            fprintf(code, "%s\n", extend(0, (6+ (5-num) * 5)));

            // I-Type
        } else if(indexI != -1){
            printf("\'%s\'\tis I-Type\n", inst[0]);

            // Print Op-Code
            fprintf(code, "%s", extend(opIType[indexI], 6));

            //from 1 because i have already wrote the opcode
            for(int i = 1; i < num - 1; i++) {

                // Last 2 chars of all inst will be ;\n so i remove them
                inst[i] = strtok(inst[i], ";\n");

                // Find the index of current register
                int regIndex = arrFindIndex(reg, inst[i], regArrSize);
                // This means that inst[i] is not reg
                if(regIndex == -1) {
                    printf("\'%s\' not found\n", inst[i]);
                    //fprintf(code, "%s", extend(value, 5));
                } else {
                    fprintf(code, "%s", extend(regIndex, 5));
                }

            }

            // strtok(inst[num-1] => MUST BE A NUMBER
            int value = atoi(strtok(inst[num-1], ";\n"));

            fprintf(code, "%s\n", extend(value, 16));

        } else {
            printf("\'%s\' not found\n", inst[0]);
        }

    }

    fclose(code);
    fclose(file);
    return 0;
}
