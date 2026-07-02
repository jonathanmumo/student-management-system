program StudentManagementSystem;

var
    choice: integer;
    studentFile: Text;
    regNo, studentName, course: string;

begin
    repeat

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

        writeln('Enter your choice:');
        readln(choice);
        writeln;

        case choice of

            1:
            begin
                writeln('===== ADD STUDENT =====');

                writeln('Registration Number:');
                readln(regNo);

                writeln('Student Name:');
                readln(studentName);

                writeln('Course:');
                readln(course);

                Assign(studentFile,'students.txt');
                Append(studentFile);

                writeln(studentFile,regNo,'|',studentName,'|',course);

                Close(studentFile);

                writeln;
                writeln('Student saved successfully!');
            end;

            2: writeln('View Students - Coming Soon');
            3: writeln('Search Student - Coming Soon');
            4: writeln('Update Student - Coming Soon');
            5: writeln('Delete Student - Coming Soon');
            6: writeln('Calculate Grades - Coming Soon');
            7: writeln('Generate Report - Coming Soon');
            8: writeln('Thank you for using the system.');

        else
            writeln('Invalid choice!');
        end;

        if choice <> 8 then
        begin
            writeln;
            writeln('Press ENTER to continue...');
            readln;
        end;

    until choice = 8;
end.