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


CREATE TABLE vets( id SERIAL PRIMARY KEY, name VARCHAR(250), age INT, date_of_graduation DATE );
CREATE TABLE specialization (id SERIAL PRIMARY KEY, species_id INT, vet_id INT, CONSTRAINT fk_species_id FOREIGN KEY(species_id) REFERENCES species(id), CONSTRAINT fk_vet_id  FOREIGN KEY(vet_id) REFERENCES vets(id));
CREATE TABLE visits (id SERIAL PRIMARY KEY, animal_id INT, vet_id INT, date_of_visit DATE, CONSTRAINT fk_animal_id FOREIGN KEY(animal_id) REFERENCES animals(id), CONSTRAINT fk_vet_id  FOREIGN KEY(vet_id) REFERENCES vets(id));


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create a non clustered index of animal_id on visits table
CREATE INDEX  animal_id_asc ON visits (animal_id ASC);

-- Create a non clustered index of vet_id on visits table
CREATE INDEX  vet_id_asc ON visits (vet_id ASC);

-- Create a non clustered index of vet_id on visits table
CREATE INDEX  owner_email_asc ON owners (email ASC);

