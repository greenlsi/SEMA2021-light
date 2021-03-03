ltl enciende {
	[] (boton -> <> luz)
}

ltl apaga {
	[] (deadline -> <> !luz)
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
        :: (boton) -> luz = 1; printf("reset_timer(30)\n"); estado = ON;
    		printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    		estado, boton, deadline, luz);
        fi
    }
    :: (estado == ON) -> atomic {
        if
        :: (boton) -> printf("reset_timer(30)\n")
        :: (deadline) -> luz = 0; estado = OFF;
    		printf ("estado = %d, boton = %d, deadline = %d, luz = %d\n",
	    		estado, boton, deadline, luz);
        fi
    }
    od
}

active proctype entorno ()
{
    do
    :: !boton -> skip
    :: boton = 1
    :: deadline = 1
    od
}

