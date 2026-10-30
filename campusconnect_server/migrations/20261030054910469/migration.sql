BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "planner_item" (
    "id" bigserial PRIMARY KEY,
    "studentId" bigint NOT NULL,
    "title" text NOT NULL,
    "category" text NOT NULL,
    "dayOfWeek" text NOT NULL,
    "timeSlot" text NOT NULL,
    "location" text,
    "description" text,
    "referenceId" bigint,
    "isCompleted" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR campusconnect
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusconnect', '20261030054910469', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261030054910469', "timestamp" = now();

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
