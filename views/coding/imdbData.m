function [st] = imdbData(title)
% % Inputs: (char) Require Film/Show Title with Optional Season and then 
% %         Optional Episode, all seperated by Commas
% % 
% %         Ex. title = 'Game of Thrones,3,2'; %Game of Thrones, Season: 3, 
% %             out = imdbData(title);          Episode: 2
% %         ---------------OR ------------------
% %         Ex. title = 'Game of Thrones,5'; %Game of Thrones, Season: 5
% %             out = imdbData(title);
% %         ---------------OR ------------------
% %         Ex. title = 'Game of Thrones'; %Game of Thrones
% %             out = imdbData(title);
% % Outputs: (struct) Brief Description of the film/show and its
% %          'Rotten Tomato Score' if availible
% %          A 0 in the year vector indicated the show is still running
% % _______________________________________________________________________
% % 
% % Notes:
% %    ** The title must be written exaclty as it appears on imdb and
% %       rotten tomatos in order for those two outputs to correlate
% %    ** Most fields are returned as a string unless the following
% %         * There is a list indicated by comma sepreartion-->Output is a
% %           cell array
% %         * There are only numbers (possible decimal point) in the
% %           values-->Output is a double
% %         * There is a link to an image-->Output is uint8 array
% %    ** If the movie does not exist in this data base, the code will
% %       output a 1xN char with a 404 Error Message. 
% % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
st = [];
commask = [];
commas = strfind(title, ',');
mask = title(commas+1) >= '0' & title(commas+1)<= '9';
commas(mask) = [];
title(commas) = '*';
% Check inputs
if isempty(strfind(title, ','))
    title(commas) = ',';
    web = sprintf('http://www.omdbapi.com/?t=%s',title);
    season = [];
    episode = [];
elseif length(strfind(title, ',')) == 1
    [title, season] = strtok(title,',');
    title(commas) = ',';
    season = season(2:end);
    web = sprintf('http://www.omdbapi.com/?t=%s&Season=%s',title,season);
    episode = [];
elseif length(strfind(title, ',')) == 2
    [title, season] = strtok(title,',');
    [season, episode] = strtok(season, ',');
    episode = episode(2:end);
    title(commas) = ',';
    web = sprintf('http://www.omdbapi.com/?t=%s&Season=%s&Episode=%s',title,season,episode);
else
    st = '404 Error: No Data Found. No worries fam! Just check your spelling and proper use of commas!';
    web = [];    
end

% retrieve API data
if ~isempty(web)
    data = webread(web);
    fields = fieldnames(data);
    error = strfind(fields, 'Error');
    error = [error{:}];
end
if ~isempty(web) & any(error)
% % Found nothing
    st = sprintf('404 Error: %s Sorry fam... check your spelling and proper use of commas!', data.Error);
else
    for x = 1:length(fields)
        values = data.(fields{x});
        if ~strcmp(class(values), 'struct')
            charmask = lower(values) >= 'a' & lower(values) <= 'z';
            nummask = values>= '0' & values <= '9';        
        % Convert all string lists into cell arrays
        if ~isempty(strfind(values,',')) & any(charmask) & ~strcmpi(fields{x}, 'Plot') & ~strcmpi(fields{x}, 'Title')
            values = [values '   '];
            list = [];
            commaInd = [1 strfind(values, ',')+2 length(values)];
            for y = 1:length(commaInd)-1
                list = [list {values(commaInd(y):commaInd(y+1)-3)}];
            end
            data.(fields{x}) = list;
        end
                    
        % Convert fields with only numbers into doubles
        if length(data.Year) > 4 & length(data.Year)<7 & strcmpi(fields{x}, 'Year')
            yearrs =  data.Year;
            data.Year =  [str2num(yearrs(1:4)) 0];
        elseif length(data.Year) > 4 & strcmpi(fields{x}, 'Year')
            yearrs =  data.Year;
            data.Year =  [str2num(yearrs(1:4)) str2num(yearrs(6:end))];
        elseif ~any(charmask) & any(nummask)
            mask = (values>= '0' & values <= '9')|values =='.';
            values(~mask) = [];
            info = str2num(values);
            data.(fields{x}) = info;
        end
        
        %import image data if availible
        if strcmpi(fields{x}, 'Poster') & ~strcmpi(values,'N/A')
            img = webread(values);
            data.(fields{x}) = img;
        end
            
        end
    end
end
if ~ischar(st)
    st = rmfield(data, 'Response');
end

if ~ischar(st)
% Rotten Tomato Address
if strcmpi(st.Type, 'episode')
    stin = imdbData(title); %%%%RECURSION!!!!!!!
    title = stin.Title;
else
    title = st.Title;
    stin = st;
end
mask = title == ',';
title(mask) = [];
rtweb = ['https://www.rottentomatoes.com/search/?search=' title];
% Parse search
out = rtParser(rtweb,stin,title);
if isempty(out)
    out = '0%';
end
st.RottenTomatoScore = out;
end
end

