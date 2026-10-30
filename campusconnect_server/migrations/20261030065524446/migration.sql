BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "campus_event" ADD COLUMN "locationId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_location" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "category" text NOT NULL,
    "shortDescription" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "buildingBlock" text,
    "openingHours" text,
    "contactInfo" text,
    "website" text,
    "accessibilityInfo" text,
    "isVerified" boolean NOT NULL,
    "tags" json
);

-- Indexes
CREATE INDEX "campus_location_category_idx" ON "campus_location" USING btree ("category");


--
-- MIGRATION VERSION FOR campusconnect
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusconnect', '20261030065524446', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030065524446', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
