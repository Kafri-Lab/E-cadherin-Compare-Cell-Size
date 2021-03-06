function AnimalsTable = img_name_to_animal_name()
  % Download input data from master Google spreadsheet
  spreadsheet = GetGoogleSpreadsheet('13VCqz4cbSt55Wg8HDp-UT5FU8rBgKsMkV54SIO6X7YU');
  spreadsheet_subset = spreadsheet(2:end,:); % exclude first column (column names)
  AnimalsTable = cell2table(spreadsheet_subset);

  %% Map names from Google Sheet to allowed names in Matlab tables
  name_map = containers.Map;
  name_map('Timestamp') = 'Timestamp';
  name_map('Email Address') = 'Email';
  name_map('Animal name  (scientific species or taxon)') = 'Species';
  name_map('Animal name  (colloquial)') = 'Colloquial';
  name_map('Animal name (short)') = 'ShortName';
  name_map('Specimen age at death (days)') = 'DeathAge';
  name_map('Acinar cell volume (um^3)') = 'Acinar';
  name_map('Hepatocyte cell volume (um^3)') = 'Hepatocyte';
  name_map('Lifespan in captivity (years)') = 'Lifespan';
  name_map('Genome size (base pairs)') = 'GenomeBasePairs';
  name_map('Genome size (golden path length)') = 'GenomeGoldenPath';
  name_map('Weaning age (days)') = 'WeaningAge';
  name_map('Sexual maturity age (days)') = 'SexualMaturityAge';
  name_map('Birth weight (g)') = 'BirthWeight';
  name_map('Weaning weight (g)') = 'WeaningWeight';
  name_map('Sexual maturity weight (g)') = 'SexualMaturityWeight';
  name_map('Basal metabolic rate per body mass (W/g)') = 'MetabolicRate';
  name_map('Adult weight (g)') = 'AdultWeight';
  name_map('Notes') = 'Notes';
  name_map('Animal picture (URL)') = 'PictureURL';
  name_map('Feeding state') = 'Feedingstate';
  spreadsheet_column_names = spreadsheet(1,:); % names from google spreadsheet
  for i=1:length(spreadsheet_column_names)
    table_column_names{i} = name_map(spreadsheet_column_names{i});
  end
  AnimalsTable.Properties.VariableNames = table_column_names; % set proper column names

  % Set string columns that should be numeric to double type
  numeric_columns = {'DeathAge', 'Acinar', 'Hepatocyte', 'Lifespan', ...
                     'WeaningAge', 'SexualMaturityAge','BirthWeight', ...
                     'WeaningWeight', 'SexualMaturityWeight', 'AdultWeight', ...
                     'MetabolicRate','GenomeBasePairs', 'GenomeGoldenPath'};
  for i=1:length(numeric_columns)
    temp = array2table(str2double(AnimalsTable{:,numeric_columns(i)}));
    AnimalsTable(:,numeric_columns(i)) = [];
    AnimalsTable(:,numeric_columns(i)) = temp;
  end
end