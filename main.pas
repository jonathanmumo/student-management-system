program StudentManagementSystem;

uses
    SysUtils, StrUtils;

var
    
    
    choice: integer;
    studentFile, tempFile, gradeFile: Text;
    regNo, studentName, course: string;
    searchReg: string;
    line: string;
    grade, remark: string;
    found: boolean;
    catMark, assignmentMark, examMark, total: integer;
begin
    repeat

        writeln('1. Add Student');
writeln('2. View Students');
writeln('3. Search Student');
writeln('4. Update Student');
writeln('5. Delete Student');
writeln('6. Record Student Marks');
writeln('7. View Grade Report');
writeln('8. Student Transcript');
writeln('9. Exit');
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
begin
    found := False;

    writeln('===== DELETE STUDENT =====');
    write('Enter Registration Number: ');
    readln(searchReg);

    Assign(studentFile, 'students.txt');
    Reset(studentFile);

    Assign(tempFile, 'temp.txt');
    Rewrite(tempFile);

    while not EOF(studentFile) do
    begin
        readln(studentFile, line);

        if Pos(searchReg, line) = 1 then
        begin
            found := True;
            writeln('Student deleted successfully!');
        end
        else
            writeln(tempFile, line);
    end;

    Close(studentFile);
    Close(tempFile);

    Erase(studentFile);
    Rename(tempFile, 'students.txt');

    if not found then
        writeln('Student not found.');
end;
            6:
begin
    found := False;

    writeln('========== RECORD STUDENT MARKS ==========');
    writeln;
    write('Enter Registration Number: ');
    readln(searchReg);

    Assign(studentFile,'students.txt');
    Reset(studentFile);

    while not EOF(studentFile) do
    begin
        readln(studentFile,line);

        if Pos(searchReg,line)=1 then
        begin
            found := True;
            Break;
        end;
    end;

    Close(studentFile);

    if not found then
    begin
        writeln;
        writeln('Student not found!');
    end
    else
    begin
        writeln;
        writeln('Student Found');
        writeln(line);
        writeln;

        write('CAT Marks (30): ');
        readln(catMark);

        write('Assignment Marks (10): ');
        readln(assignmentMark);

        write('Exam Marks (60): ');
        readln(examMark);

        total := catMark + assignmentMark + examMark;

        if total >= 70 then
        begin
            grade := 'A';
            remark := 'Excellent';
        end
        else if total >= 60 then
        begin
            grade := 'B';
            remark := 'Very Good';
        end
        else if total >= 50 then
        begin
            grade := 'C';
            remark := 'Good';
        end
        else if total >= 40 then
        begin
            grade := 'D';
            remark := 'Pass';
        end
        else
        begin
            grade := 'F';
            remark := 'Fail';
        end;

        Assign(gradeFile,'grades.txt');
        Append(gradeFile);

        writeln(
            gradeFile,
            searchReg,'|',
            catMark,'|',
            assignmentMark,'|',
            examMark,'|',
            total,'|',
            grade,'|',
            remark
        );

        Close(gradeFile);

        writeln;
        writeln('Total Marks : ',total);
        writeln('Grade       : ',grade);
        writeln('Remark      : ',remark);
        writeln;
        writeln('Grade recorded successfully!');
    end;
end;
           7:
begin
    Assign(gradeFile, 'grades.txt');
    Reset(gradeFile);

    writeln('================================================================================');
    writeln('                           STUDENT GRADE REPORT');
    writeln('================================================================================');
    writeln('Reg No          CAT  ASSIGN  EXAM  TOTAL  GRADE   REMARK');
    writeln('--------------------------------------------------------------------------------');

    while not EOF(gradeFile) do
    begin
        readln(gradeFile, line);

        regNo := Copy(line, 1, Pos('|', line) - 1);
        Delete(line, 1, Pos('|', line));

        catMark := StrToInt(Copy(line, 1, Pos('|', line) - 1));
        Delete(line, 1, Pos('|', line));

        assignmentMark := StrToInt(Copy(line, 1, Pos('|', line) - 1));
        Delete(line, 1, Pos('|', line));

        examMark := StrToInt(Copy(line, 1, Pos('|', line) - 1));
        Delete(line, 1, Pos('|', line));

        total := StrToInt(Copy(line, 1, Pos('|', line) - 1));
        Delete(line, 1, Pos('|', line));

        grade := Copy(line, 1, Pos('|', line) - 1);
        Delete(line, 1, Pos('|', line));

        remark := line;

        writeln(
            regNo:15, ' ',
            catMark:4, ' ',
            assignmentMark:7, ' ',
            examMark:5, ' ',
            total:6, ' ',
            grade:6, ' ',
            remark
        );
    end;

    Close(gradeFile);
end;

            8:
begin
    found := False;

    writeln('========== STUDENT TRANSCRIPT ==========');
    writeln;
    write('Enter Registration Number: ');
    readln(searchReg);

    Assign(studentFile,'students.txt');
    Reset(studentFile);

    while not EOF(studentFile) do
    begin
        readln(studentFile,line);

        if Pos(searchReg,line)=1 then
        begin
            found := True;

            regNo := Copy(line,1,Pos('|',line)-1);
            Delete(line,1,Pos('|',line));

            studentName := Copy(line,1,Pos('|',line)-1);
            Delete(line,1,Pos('|',line));

            course := line;

            Break;
        end;
    end;

    Close(studentFile);

    if not found then
    begin
        writeln;
        writeln('Student not found!');
    end
    else
    begin
        Assign(gradeFile,'grades.txt');
        Reset(gradeFile);

        while not EOF(gradeFile) do
        begin
            readln(gradeFile,line);

            if Pos(searchReg,line)=1 then
            begin
                Delete(line,1,Pos('|',line));

                catMark := StrToInt(Copy(line,1,Pos('|',line)-1));
                Delete(line,1,Pos('|',line));

                assignmentMark := StrToInt(Copy(line,1,Pos('|',line)-1));
                Delete(line,1,Pos('|',line));

                examMark := StrToInt(Copy(line,1,Pos('|',line)-1));
                Delete(line,1,Pos('|',line));

                total := StrToInt(Copy(line,1,Pos('|',line)-1));
                Delete(line,1,Pos('|',line));

                grade := Copy(line,1,Pos('|',line)-1);
                Delete(line,1,Pos('|',line));

                remark := line;

                writeln;
                writeln('=========================================');
                writeln('          STUDENT TRANSCRIPT');
                writeln('=========================================');
                writeln('Registration No : ', regNo);
                writeln('Student Name    : ', studentName);
                writeln('Course          : ', course);
                writeln;
                writeln('CAT Marks       : ', catMark);
                writeln('Assignment      : ', assignmentMark);
                writeln('Exam Marks      : ', examMark);
                writeln('Total Marks     : ', total);
                writeln('Grade           : ', grade);
                writeln('Remark          : ', remark);

                Break;
            end;
        end;

        Close(gradeFile);
    end;
end;

9:
    writeln('Thank you for using the Student Management System.');
        else
            writeln('Invalid choice!');
        end;

        if choice <> 9 then
        begin
            writeln;
            writeln('Press ENTER to continue...');
            readln;
        end;

    until choice = 9;

end.