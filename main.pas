program StudentManagementSystem;

uses
    strutils;

var
    
    choice: integer;
    studentFile, tempFile: Text;
    regNo, studentName, course: string;
    searchReg: string;
    line: string;
    found: boolean;

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
begin
    found := False;

    writeln('===== SEARCH STUDENT =====');
    writeln;
    write('Enter Registration Number: ');
    readln(regNo);

    Assign(studentFile, 'students.txt');
    Reset(studentFile);

    while not EOF(studentFile) do
    begin
        readln(studentFile, line);

        if Pos(regNo, line) = 1 then
        begin
            writeln;
            writeln('Student Found');
            writeln('---------------------------');
            writeln(line);
            found := True;
            Break;
        end;
    end;

    Close(studentFile);

    if not found then
    begin
        writeln;
        writeln('Student not found.');
    end;
end;

            4:
begin
    found := False;

    writeln('===== UPDATE STUDENT =====');
    write('Enter Registration Number: ');
    readln(searchReg);

    Assign(studentFile,'students.txt');
    Reset(studentFile);

    Assign(tempFile,'temp.txt');
    Rewrite(tempFile);

    while not EOF(studentFile) do
    begin
        readln(studentFile,line);

        if Pos(searchReg,line)=1 then
        begin
            found := True;

            writeln;
            writeln('Student Found');
            writeln(line);
            writeln;

            write('New Registration Number: ');
            readln(regNo);

            write('New Name: ');
            readln(studentName);

            write('New Course: ');
            readln(course);

            writeln(tempFile,
                regNo,'|',
                studentName,'|',
                course);
        end
        else
            writeln(tempFile,line);
    end;

    Close(studentFile);
    Close(tempFile);

    Erase(studentFile);
    Rename(tempFile,'students.txt');

    if found then
        writeln('Student updated successfully!')
    else
        writeln('Student not found.');
end;

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