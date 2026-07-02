program StudentManagementSystem;

uses crt;

var
    choice : integer;

begin
    clrscr;

    writeln('====================================');
    writeln('     STUDENT MANAGEMENT SYSTEM');
    writeln('====================================');
    writeln;
    writeln('1. Add Student');
    writeln('2. View Students');
    writeln('3. Search Student');
    writeln('4. Update Student');
    writeln('5. Delete Student');
    writeln('6. Calculate Grades');
    writeln('7. Generate Report');
    writeln('8. Exit');
    writeln;

    write('Enter your choice: ');
    readln(choice);

    case choice of
        1: writeln('You selected Add Student.');
        2: writeln('You selected View Students.');
        3: writeln('You selected Search Student.');
        4: writeln('You selected Update Student.');
        5: writeln('You selected Delete Student.');
        6: writeln('You selected Calculate Grades.');
        7: writeln('You selected Generate Report.');
        8: writeln('Exiting program...');
    else
        writeln('Invalid choice!');
    end;

    writeln;
    writeln('Press ENTER to continue...');
    readln;
end.