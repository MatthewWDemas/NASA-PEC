%Set preferences with setdbprefs.
% setdbprefs('DataReturnFormat', 'cellarray');
% setdbprefs('NullNumberRead', 'NaN');
% setdbprefs('NullStringRead', 'null');
% 

%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('nasa_pec', 'root', 'PWD HERE', 'Vendor', 'MySQL', 'Server', 'SERVER IP ADDRESS HERE');

%Read data from database.
curs = exec(conn, ['SELECT 	matb_scores_raw.Subject'...
    ' ,	matb_scores_raw.Runid'...
    ' ,	matb_scores_raw.Protocol'...
    ' ,	matb_scores_raw.Sessionid'...
    ' ,	matb_scores_raw.Task'...
    ' ,	matb_scores_raw.Run'...
    ' ,	matb_scores_raw.Trial'...
    ' ,	matb_scores_raw.Trialid'...
    ' ,	matb_scores_raw.SubjectTrial'...
    ' ,	matb_scores_raw.SessionOrder'...
    ' ,	matb_scores_raw.RunOrder'...
    ' ,	matb_scores_raw.Track'...
    ' ,	matb_scores_raw.Comm'...
    ' ,	matb_scores_raw.ResMan'...
    ' ,	matb_scores_raw.Time'...
    ' FROM 	`nasa_pec`.matb_scores_raw '...
    ' WHERE 	matb_scores_raw.Run LIKE ''SL'''...
    ' AND 	matb_scores_raw.Subject LIKE ''S57''']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
untitled = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn