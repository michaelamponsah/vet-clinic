/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY, 
  name VARCHAR(250),
  date_of_birth DATE, 
  escape_attempts INT, 
  neutered BOOL, 
  weight_kg DOUBLE PRECISION, 
  species VARCHAR(250),
);

 CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  fullname VARCHAR(250),
  age INT,
  PRIMARY KEY(id),
);

   CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY(ID)
  );

  ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;
  ALTER TABLE animalS ADD COLUMN species_id INTEGER;
  ALTER TABLE animalS ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species(id);
  ALTER TABLE animalS ADD owner_id FOREIGN KEY REFERENCES  owners(id); 

   ALTER TABLE animalS ADD COLUMN owner_id INTEGER;
    ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners(id);