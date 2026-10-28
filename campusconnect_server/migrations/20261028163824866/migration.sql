BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_notification" (
    "id" bigserial PRIMARY KEY,
    "recipientId" bigint NOT NULL,
    "activityType" text NOT NULL,
    "title" text NOT NULL,
    "message" text NOT NULL,
    "isRead" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_event" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "category" text NOT NULL,
    "venue" text NOT NULL,
    "startTime" timestamp without time zone NOT NULL,
    "endTime" timestamp without time zone NOT NULL,
    "organizer" text NOT NULL,
    "organizerId" bigint,
    "isPublished" boolean NOT NULL,
    "capacity" bigint NOT NULL,
    "registeredCount" bigint NOT NULL,
    "bannerColor" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "collaboration_request" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "projectTitle" text NOT NULL,
    "projectCreatorId" bigint NOT NULL,
    "studentId" bigint NOT NULL,
    "studentName" text NOT NULL,
    "studentBranch" text NOT NULL,
    "studentSkills" json NOT NULL,
    "message" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "event_bookmark" (
    "id" bigserial PRIMARY KEY,
    "studentId" bigint NOT NULL,
    "eventId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "event_registration" (
    "id" bigserial PRIMARY KEY,
    "studentId" bigint NOT NULL,
    "studentName" text NOT NULL,
    "studentEmail" text NOT NULL,
    "eventId" bigint NOT NULL,
    "eventTitle" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project_listing" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "creatorId" bigint NOT NULL,
    "creatorName" text NOT NULL,
    "creatorBranch" text NOT NULL,
    "techStack" json NOT NULL,
    "requiredSkills" json NOT NULL,
    "category" text NOT NULL,
    "totalPositions" bigint NOT NULL,
    "openPositions" bigint NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "branch" text NOT NULL,
    "academicYear" text NOT NULL,
    "bio" text NOT NULL,
    "avatarUrl" text,
    "skills" json NOT NULL,
    "interests" json NOT NULL,
    "isOrganizer" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "study_preferences" (
    "id" bigserial PRIMARY KEY,
    "studentId" bigint NOT NULL,
    "subjects" json NOT NULL,
    "technicalInterests" json NOT NULL,
    "preferredTimings" json NOT NULL,
    "studyMode" text NOT NULL,
    "learningGoals" json NOT NULL,
    "skillLevel" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "study_request" (
    "id" bigserial PRIMARY KEY,
    "senderId" bigint NOT NULL,
    "senderName" text NOT NULL,
    "senderBranch" text NOT NULL,
    "senderAvatarUrl" text,
    "recipientId" bigint NOT NULL,
    "recipientName" text NOT NULL,
    "message" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR campusconnect
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusconnect', '20261028163824866', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261028163824866', "timestamp" = now();

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
