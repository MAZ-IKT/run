clear all;
%filedir = '/home/celik/OpenFOAM/celik-2.3.x/run/Diss/Final_neu/hintereinander/S1_15_0.9_S2_15_0.9/drop/n500/postProcessing/surfaces/1.2'; %muss noch angepasst werden
filedir = '/home/tanja/OpenFOAM/tanja-8/run/tests/Drop/WS0_500_PP-PS-15/postProcessing/surfaces/1.2'
matfiles = dir(fullfile(filedir, '*.raw'));
nfiles = length(matfiles);
M=[];
nfiles;
disp('hallo')
matfiles;
for i = 1 : nfiles
    fid = fopen( fullfile(filedir, matfiles(i).name) );
    %Zeilen 1 und 2 nicht beachten
    fgetl(fid);
    fgetl(fid);
    data = fscanf(fid,'%f');
    data_neu=data(4:4:end); %nur jeden 4. Wert beginnend beim 4. Wert verwenden
    M=[M data_neu]; %1.Spalte=N1, 2.Spalte=N2 etc.
    S=sum(M(:,i));
    summiert(i)=sum(S); %1.Spalte=aufsummierte N1, 2. Spalte= aufsummierte N2 etc
    fclose(fid);
    summiert;
end

%Ausgabe im Terminal
M;
format long g %um summiert nicht wissenschaftlich auszugeben
%summiert;
%format short 
%S1=sum(summiert,2);
%proz=(summiert/S1)*100;

%Balkendiagramm erzeugen
%bar(proz)
%xlabel('Tropfengröße');
%ylabel('prozentualer Anteil [%]');

%Ausgabe in .txt Datei
fid = fopen('Ausgabe.txt', 'w');
fprintf(fid, '%s\n', 'Einzelne Werte (von N=1 bis N=i)');
for ii = 1:size(M,1)     %Da Größe der Matrix nicht bekannt
    fprintf(fid,'%12.3f',M(ii,:));
    fprintf(fid,'\n'); %Zeilenumbruch
end
fprintf(fid, '\n');
fprintf(fid, '%s\n', 'Aufsummierte Werte (von N=1 bis N=i)');
%for ii = 1:size(summiert,1)
%    fprintf(fid,'%12.3f',summiert(ii,:));
%    fprintf(fid,'\n'); 
%end
fprintf(fid, '\n');
fprintf(fid, '%s\n', 'Aufsummierte Werte (von N=1 bis N=i)');
%for ii = 1:size(proz,1)
%   fprintf(fid,'%12.3f',proz(ii,:));
%    fprintf(fid,'\n');
%end
fclose(fid); 
