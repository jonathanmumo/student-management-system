program StudentManagementSystem;

uses
    strutils;

var
    choice: integer;
    studentFile: Text;
    regNo, studentName, course, line: string;

begin
    repeat

        writeln('==============================================================');
        writeln('                STUDENT MANAGEMENT SYSTEM');
        writeln('==============================================================');
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

            {================ ADD STUDENT ================}
            1:
            begin
                writeln('========== ADD STUDENT ==========');

                writeln('Registration Number:');
                readln(regNo);

                writeln('Student Name:');
                readln(studentName);

                writeln('Course:');
                readln(course);

                Assign(studentFile, 'students.txt');
                Append(studentFile);

                writeln(studentFile, regNo, '|', studentName, '|', course);

                Close(studentFile);

                writeln;
                writeln('Student saved successfully!');
            end;

            {================ VIEW STUDENTS ================}
            2:
            begin
                Assign(studentFile, 'students.txt');
                Reset(studentFile);

                writeln('==============================================================');
                writeln('REG NO              STUDENT NAME             COURSE');
                writeln('==============================================================');

                while not EOF(studentFile) do
                begin
                    readln(studentFile, line);

                    regNo := Copy(line, 1, Pos('|', line) - 1);
                    Delete(line, 1, Pos('|', line));

                    studentName := Copy(line, 1, Pos('|', line) - 1);
                    Delete(line, 1, Pos('|', line));

                    course := line;

                    writeln(regNo:18, '  ', studentName:25, '  ', course);
                end;

                Close(studentFile);
            end;

            {================ PLACEHOLDERS ================}
            3:
                writeln('Search Student - Coming Soon');

            4:
                writeln('Update Student - Coming Soon');

            5:
                writeln('Delete Student - Coming Soon');

            6:
                writeln('Calculate Grades - Coming Soon');

            7:
                writeln('Generate Report - Coming Soon');

            8:
                writeln('Thank you for using the Student Management System.');

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