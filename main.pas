program StudentManagementSystem;

uses
    SysUtils, StrUtils;

const
    MAX = 100;

var


  
    bestReg: string;
    bestGrade: string;
    bestRemark: string;
    bestTotal: integer;

    confirm: char;
    searchChoice: integer;
    searchName: string;

    choice: integer;
    studentFile, tempFile, gradeFile: Text;
    regNo, studentName, course: string;
    searchReg: string;
    line: string;
    grade, remark: string;
    found: boolean;
    catMark, assignmentMark, examMark, total: integer;

    highest, lowest: integer;
    sum: integer;
    count: integer;
    average: real;

    gradeA, gradeB, gradeC, gradeD, gradeF: integer;

    studentCount, gradeCount: integer;
    highestScore, totalScore: integer;
    averageScore: real;

    rankReg: array[1..MAX] of string;
    rankName: array[1..MAX] of string;
    rankGrade: array[1..MAX] of string;
    rankTotal: array[1..MAX] of integer;

    i, j, n: integer;

    tempReg: string;
    tempName: string;
    tempGrade: string;
    tempTotal: integer;

function ValidRegNo(reg: string): boolean;
var
  slashPos1, slashPos2: integer;
  i, yearNum, codeCheck: integer;
  regClean, part1, part2, part3: string;
begin
  ValidRegNo := False;

  regClean := UpperCase(Trim(reg));

  slashPos1 := Pos('/', regClean);
  if slashPos1 = 0 then Exit;

  slashPos2 := Pos('/', Copy(regClean, slashPos1 + 1, Length(regClean)));
  if slashPos2 = 0 then Exit;
  slashPos2 := slashPos1 + slashPos2;

  part1 := Copy(regClean, 1, slashPos1 - 1);
  part2 := Copy(regClean, slashPos1 + 1, slashPos2 - slashPos1 - 1);
  part3 := Copy(regClean, slashPos2 + 1, Length(regClean));

  if part1 <> 'CCS' then Exit;

  for i := 1 to Length(part2) do
    if not (part2[i] in ['0'..'9']) then Exit;

  for i := 1 to Length(part3) do
    if not (part3[i] in ['0'..'9']) then Exit;

  Val(part3, yearNum, codeCheck);
  if codeCheck <> 0 then Exit;

  if yearNum < 21 then Exit;

  ValidRegNo := True;
end;
begin
repeat
studentCount := 0;

Assign(studentFile,'students.txt');
Reset(studentFile);

while not EOF(studentFile) do
begin
    readln(studentFile,line);
    Inc(studentCount);
end;

Close(studentFile);
gradeCount := 0;
highestScore := 0;
totalScore := 0;

Assign(gradeFile,'grades.txt');
Reset(gradeFile);

while not EOF(gradeFile) do
begin
    readln(gradeFile,line);

    { Skip Reg No }
    Delete(line,1,Pos('|',line));

    { Skip CAT }
    Delete(line,1,Pos('|',line));

    { Skip Assignment }
    Delete(line,1,Pos('|',line));

    { Skip Exam }
    Delete(line,1,Pos('|',line));

    { Read Total }
    total := StrToInt(Copy(line,1,Pos('|',line)-1));

    Inc(gradeCount);
    totalScore := totalScore + total;

    if total > highestScore then
        highestScore := total;
end;

Close(gradeFile);

if gradeCount > 0 then
    averageScore := totalScore / gradeCount
else
    averageScore := 0;
writeln('=========================================');
writeln('      STUDENT MANAGEMENT SYSTEM');
writeln('=========================================');
writeln('Students Registered : ', studentCount);
writeln('Grades Recorded     : ', gradeCount);
writeln('Highest Score       : ', highestScore);
writeln('Average Score       : ', averageScore:0:2);
writeln('=========================================');
writeln;
       writeln('1. Add Student');
writeln('2. View Students');
writeln('3. Search Student');
writeln('4. Update Student');
writeln('5. Delete Student');
writeln('6. Record Student Marks');
writeln('7. View Grade Report');
writeln('8. Student Transcript');
writeln('9. Student Statistics');
writeln('10. Best Student');
writeln('11. Class ranking');
writeln('12. Exit');
        writeln;

        writeln('Enter your choice:');
        readln(choice);
        writeln;

        case choice of

            {================ ADD STUDENT ================}
            1:
            begin
                writeln('========== ADD STUDENT ==========');

                
   repeat
    write('Registration Number: ');
    readln(regNo);

    if Trim(regNo) = '' then
        writeln('Registration Number cannot be empty.')
    else if not ValidRegNo(regNo) then
        writeln('Invalid format! Example: CCS/00037/021');
until (Trim(regNo) <> '') and ValidRegNo(regNo);

found := False;

Assign(studentFile,'students.txt');
Reset(studentFile);

while not EOF(studentFile) do
begin
    readln(studentFile,line);

    if Pos(regNo,line)=1 then
    begin
        found := True;
        Break;
    end;
end;

Close(studentFile);

if found then
begin
    writeln;
    writeln('Registration number already exists!');
end
else
begin
    repeat
    write('Student Name: ');
    readln(studentName);

    if Trim(studentName) = '' then
        writeln('Student Name cannot be empty.');
until Trim(studentName) <> '';

    repeat
    write('Course: ');
    readln(course);

    if Trim(course) = '' then
        writeln('Course cannot be empty.');
until Trim(course) <> '';

    Assign(studentFile,'students.txt');
    Append(studentFile);

    writeln(studentFile,
        regNo,'|',
        studentName,'|',
        course);

    Close(studentFile);

    writeln;
    writeln('Student saved successfully!');

end;
         
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
    writeln('1. Search by Registration Number');
    writeln('2. Search by Student Name');
    write('Enter choice: ');
    readln(searchChoice);
    writeln;

    Assign(studentFile,'students.txt');
    Reset(studentFile);

    if searchChoice = 1 then
    begin
        write('Enter Registration Number: ');
        readln(regNo);

        while not EOF(studentFile) do
        begin
            readln(studentFile,line);

            if Pos(regNo,line)=1 then
            begin
                writeln;
                writeln('Student Found');
                writeln('---------------------------');
                writeln(line);
                found := True;
                Break;
            end;
        end;
    end
    else if searchChoice = 2 then
    begin
        write('Enter Student Name: ');
        readln(searchName);

        while not EOF(studentFile) do
        begin
            readln(studentFile,line);

            if Pos(LowerCase(searchName), LowerCase(line)) > 0 then
            begin
                writeln;
                writeln('Student Found');
                writeln('---------------------------');
                writeln(line);
                found := True;
            end;
        end;
    end
    else
    begin
        writeln('Invalid choice.');
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

    
    repeat
    write('New Registration Number: ');
    readln(regNo);

    if Trim(regNo) = '' then
        writeln('Registration Number cannot be empty.')
    else if not ValidRegNo(regNo) then
        writeln('Invalid format! Example: CCS/00037/021');
until (Trim(regNo) <> '') and ValidRegNo(regNo);

            repeat
    write('New Name: ');
    readln(studentName);

    if Trim(studentName) = '' then
        writeln('Student Name cannot be empty.');
until Trim(studentName) <> '';

           repeat
    write('New Course: ');
    readln(course);

    if Trim(course) = '' then
        writeln('Course cannot be empty.');
until Trim(course) <> '';

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
    write('Delete this student? (Y/N): ');
    readln(confirm);

    if UpCase(confirm) = 'Y' then
    begin
        found := True;
        writeln('Student deleted successfully!');
    end
    else
    begin
        writeln(tempFile, line);
        writeln('Deletion cancelled.');
    end;
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

    { Check student exists }
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
        { Check if grades already exist }
        found := False;

        Assign(gradeFile,'grades.txt');
        Reset(gradeFile);

        while not EOF(gradeFile) do
        begin
            readln(gradeFile,line);

            if Pos(searchReg,line)=1 then
            begin
                found := True;
                Break;
            end;
        end;

        Close(gradeFile);

        if found then
        begin
            writeln;
            writeln('Grades already recorded for this student!');
        end
        else
        begin
            repeat
                write('CAT Marks (0-30): ');
                readln(catMark);
            until (catMark>=0) and (catMark<=30);

            repeat
                write('Assignment Marks (0-10): ');
                readln(assignmentMark);
            until (assignmentMark>=0) and (assignmentMark<=10);

            repeat
                write('Exam Marks (0-60): ');
                readln(examMark);
            until (examMark>=0) and (examMark<=60);

            total := catMark + assignmentMark + examMark;

            if total>=70 then
            begin
                grade:='A';
                remark:='Excellent';
            end
            else if total>=60 then
            begin
                grade:='B';
                remark:='Very Good';
            end
            else if total>=50 then
            begin
                grade:='C';
                remark:='Good';
            end
            else if total>=40 then
            begin
                grade:='D';
                remark:='Pass';
            end
            else
            begin
                grade:='F';
                remark:='Fail';
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
begin
    highest := 0;
    lowest := 100;
    sum := 0;
    count := 0;

    gradeA := 0;
    gradeB := 0;
    gradeC := 0;
    gradeD := 0;
    gradeF := 0;

    Assign(gradeFile,'grades.txt');
    Reset(gradeFile);

    while not EOF(gradeFile) do
    begin
        readln(gradeFile,line);

        regNo := Copy(line,1,Pos('|',line)-1);
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

        if total > highest then
            highest := total;

        if total < lowest then
            lowest := total;

        sum := sum + total;
        count := count + 1;

        if grade='A' then
            gradeA := gradeA + 1
        else if grade='B' then
            gradeB := gradeB + 1
        else if grade='C' then
            gradeC := gradeC + 1
        else if grade='D' then
            gradeD := gradeD + 1
        else
            gradeF := gradeF + 1;
    end;

    Close(gradeFile);

    if count > 0 then
        average := sum / count
    else
        average := 0;

    writeln;
    writeln('==========================================');
    writeln('         STUDENT STATISTICS');
    writeln('==========================================');
    writeln('Students Graded : ',count);
    writeln('Highest Score   : ',highest);
    writeln('Lowest Score    : ',lowest);
    writeln('Average Score   : ',average:0:2);
    writeln;
    writeln('Grade Distribution');
    writeln('--------------------------');
    writeln('A : ',gradeA);
    writeln('B : ',gradeB);
    writeln('C : ',gradeC);
    writeln('D : ',gradeD);
    writeln('F : ',gradeF);
end;
10:
begin
    bestTotal := -1;

    Assign(gradeFile,'grades.txt');
    Reset(gradeFile);

    while not EOF(gradeFile) do
    begin
        readln(gradeFile,line);

        regNo := Copy(line,1,Pos('|',line)-1);
        Delete(line,1,Pos('|',line));

        Delete(line,1,Pos('|',line));
        Delete(line,1,Pos('|',line));
        Delete(line,1,Pos('|',line));

        total := StrToInt(Copy(line,1,Pos('|',line)-1));
        Delete(line,1,Pos('|',line));

        grade := Copy(line,1,Pos('|',line)-1);
        Delete(line,1,Pos('|',line));

        remark := line;

        if total > bestTotal then
        begin
            bestTotal := total;
            bestReg := regNo;
            bestGrade := grade;
            bestRemark := remark;
        end;
    end;

    Close(gradeFile);

    if bestTotal = -1 then
    begin
        writeln('No grades have been recorded.');
    end
    else
    begin
        Assign(studentFile,'students.txt');
        Reset(studentFile);

        while not EOF(studentFile) do
        begin
            readln(studentFile,line);

            if Pos(bestReg,line)=1 then
            begin
                Delete(line,1,Pos('|',line));

                studentName := Copy(line,1,Pos('|',line)-1);
                Delete(line,1,Pos('|',line));

                course := line;

                Break;
            end;
        end;

        Close(studentFile);

        writeln;
        writeln('=========================================');
        writeln('          BEST STUDENT REPORT');
        writeln('=========================================');
        writeln('Registration : ',bestReg);
        writeln('Name         : ',studentName);
        writeln('Course       : ',course);
        writeln('Total Marks  : ',bestTotal);
        writeln('Grade        : ',bestGrade);
        writeln('Remark       : ',bestRemark);
    end;
end;
11:
begin
    writeln;
    writeln('==============================================');
    writeln('              CLASS RANKING');
    writeln('==============================================');
    writeln;

    n := 0;

Assign(gradeFile,'grades.txt');
Reset(gradeFile);

while not EOF(gradeFile) do
begin
    readln(gradeFile,line);

    Inc(n);

    { Registration Number }
    rankReg[n] := Copy(line,1,Pos('|',line)-1);
    Delete(line,1,Pos('|',line));

    { Skip CAT }
    Delete(line,1,Pos('|',line));

    { Skip Assignment }
    Delete(line,1,Pos('|',line));

    { Skip Exam }
    Delete(line,1,Pos('|',line));

    { Total Marks }
    rankTotal[n] := StrToInt(Copy(line,1,Pos('|',line)-1));
    Delete(line,1,Pos('|',line));

    { Grade }
    rankGrade[n] := Copy(line,1,Pos('|',line)-1);

    rankName[n] := '';
end;

Close(gradeFile);

Assign(studentFile,'students.txt');
Reset(studentFile);

while not EOF(studentFile) do
begin
    readln(studentFile,line);

    regNo := Copy(line,1,Pos('|',line)-1);
    Delete(line,1,Pos('|',line));

    studentName := Copy(line,1,Pos('|',line)-1);

    for i := 1 to n do
    begin
        if rankReg[i] = regNo then
        begin
            rankName[i] := studentName;
            Break;
        end;
    end;
end;

Close(studentFile);
for i := 1 to n - 1 do
begin
    for j := 1 to n - i do
    begin
        if rankTotal[j] < rankTotal[j + 1] then
        begin
            { Swap Total }
            tempTotal := rankTotal[j];
            rankTotal[j] := rankTotal[j + 1];
            rankTotal[j + 1] := tempTotal;

            { Swap Registration Number }
            tempReg := rankReg[j];
            rankReg[j] := rankReg[j + 1];
            rankReg[j + 1] := tempReg;

            { Swap Student Name }
            tempName := rankName[j];
            rankName[j] := rankName[j + 1];
            rankName[j + 1] := tempName;

            { Swap Grade }
            tempGrade := rankGrade[j];
            rankGrade[j] := rankGrade[j + 1];
            rankGrade[j + 1] := tempGrade;
        end;
    end;
end;

writeln;
writeln('==============================================================');
writeln('Rank  Reg No           Student Name              Total  Grade');
writeln('==============================================================');

for i := 1 to n do
begin
    writeln(
        i:3,'   ',
        rankReg[i]:15,'   ',
        rankName[i]:25,'   ',
        rankTotal[i]:5,'   ',
        rankGrade[i]
    );
end;

end;

12:
    writeln('Thank you for using the Student Management System.');
        else
            writeln('Invalid choice!');
        end;

        if choice <> 12 then
        begin
            writeln;
            writeln('Press ENTER to continue...');
            readln;
        end;

    until choice = 12;

end.