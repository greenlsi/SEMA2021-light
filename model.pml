ltl enciende {
	[] (boton -> <> luz)
}

ltl apaga {
	[] ((deadline && (!boton W !luz)) -> <> !luz)
}


mtype = { OFF, ON }

int boton;
int deadline;

int luz;

active proctype fsm () 
{
    int estado = OFF;
    printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    estado, boton, deadline, luz);
    do
    :: (estado == OFF) -> atomic {
        if
        :: (boton) -> luz = 1; boton = 0; deadline = 0; 
		printf("reset_timer(30)\n"); estado = ON;
    		printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    		estado, boton, deadline, luz);
        fi
    }
    :: (estado == ON) -> atomic {
        if
        :: (boton) -> boton = 0; deadline = 0; printf("reset_timer(30)\n")
    		printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    		estado, boton, deadline, luz);
        :: (deadline) -> deadline = 0; luz = 0; estado = OFF;
    		printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    		estado, boton, deadline, luz);
        fi
    }
    od
}

active proctype entorno ()
{
    do
    :: if
       :: skip -> skip
       :: boton = 1
       :: deadline = 1
       fi ;
       printf ("boton = %d, deadline = %d, luz = %d\n",
	    	boton, deadline, luz);
    od
}

