CREATE TABLE `ai_usage` (
	`id` text PRIMARY KEY NOT NULL,
	`request_id` text NOT NULL,
	`actor_id` text NOT NULL,
	`created_at` text NOT NULL,
	`model` text NOT NULL,
	`prompt_version` text NOT NULL,
	`design_revision` integer NOT NULL,
	`evidence_hash` text NOT NULL,
	`input_tokens` integer,
	`output_tokens` integer,
	`total_tokens` integer,
	`duration` integer NOT NULL,
	`tool_count` integer NOT NULL,
	`status` text NOT NULL,
	`error_code` text,
	`provider_request_id` text
);
--> statement-breakpoint
CREATE INDEX `usage_actor_time` ON `ai_usage` (`actor_id`,`created_at`);--> statement-breakpoint
CREATE TABLE `audit_events` (
	`id` text PRIMARY KEY NOT NULL,
	`timestamp` text NOT NULL,
	`request_id` text NOT NULL,
	`event_type` text NOT NULL,
	`actor_id` text,
	`team_id` text,
	`entity_id` text,
	`metadata` text NOT NULL,
	`outcome` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `audit_entity_time` ON `audit_events` (`entity_id`,`timestamp`);--> statement-breakpoint
CREATE TABLE `countries` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`country_code` text NOT NULL,
	`indicative_region` text NOT NULL,
	`region_selection_claim_id` text
);
--> statement-breakpoint
CREATE UNIQUE INDEX `countries_name_unique` ON `countries` (`name`);--> statement-breakpoint
CREATE TABLE `design_claims` (
	`id` text PRIMARY KEY NOT NULL,
	`design_id` text NOT NULL,
	`country_id` text,
	`text` text NOT NULL,
	`type` text NOT NULL,
	`source_ids` text NOT NULL,
	`status` text NOT NULL,
	`value` real,
	`unit` text,
	`rationale` text NOT NULL,
	`uncertainty` text NOT NULL,
	`updated_at` text NOT NULL,
	`supersedes_id` text,
	FOREIGN KEY (`design_id`) REFERENCES `designs`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `claim_lookup` ON `design_claims` (`design_id`,`type`,`status`);--> statement-breakpoint
CREATE TABLE `design_revisions` (
	`id` text PRIMARY KEY NOT NULL,
	`design_id` text NOT NULL,
	`revision` integer NOT NULL,
	`inputs_json` text NOT NULL,
	`evidence_snapshot` text NOT NULL,
	`reason` text NOT NULL,
	`actor_id` text,
	`created_at` text NOT NULL,
	FOREIGN KEY (`design_id`) REFERENCES `designs`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `design_revision_unique` ON `design_revisions` (`design_id`,`revision`);--> statement-breakpoint
CREATE TABLE `designs` (
	`id` text PRIMARY KEY NOT NULL,
	`team_id` text NOT NULL,
	`selected_country_id` text,
	`current_revision` integer NOT NULL,
	`it_load_mw` real NOT NULL,
	`pue` real NOT NULL,
	`cooling` text NOT NULL,
	`backup` text NOT NULL,
	`network` text NOT NULL,
	`storage` text NOT NULL,
	`summary` text NOT NULL,
	`inputs_json` text NOT NULL,
	`updated_at` text NOT NULL,
	FOREIGN KEY (`selected_country_id`) REFERENCES `countries`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `metrics` (
	`id` text PRIMARY KEY NOT NULL,
	`country_id` text NOT NULL,
	`metric_name` text NOT NULL,
	`value` real,
	`structured_json` text,
	`unit` text NOT NULL,
	`period` text NOT NULL,
	`source_id` text NOT NULL,
	`retrieved_at` text NOT NULL,
	`limitation` text NOT NULL,
	`definition` text NOT NULL,
	`geographic_scope` text NOT NULL,
	`refresh_run_id` text,
	`supersedes_id` text,
	FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`source_id`) REFERENCES `sources`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `metric_lookup` ON `metrics` (`country_id`,`metric_name`,`period`,`retrieved_at`);--> statement-breakpoint
CREATE TABLE `refresh_runs` (
	`id` text PRIMARY KEY NOT NULL,
	`adapter_id` text NOT NULL,
	`request_id` text NOT NULL,
	`actor_id` text,
	`started_at` text NOT NULL,
	`finished_at` text,
	`outcome` text NOT NULL,
	`response_hash` text,
	`accepted` integer NOT NULL,
	`rejected` integer NOT NULL,
	`previous_snapshot` text,
	`new_snapshot` text,
	`error_code` text
);
--> statement-breakpoint
CREATE INDEX `refresh_time` ON `refresh_runs` (`adapter_id`,`started_at`);--> statement-breakpoint
CREATE TABLE `sources` (
	`id` text PRIMARY KEY NOT NULL,
	`publisher` text NOT NULL,
	`title` text NOT NULL,
	`url` text NOT NULL,
	`source_type` text NOT NULL,
	`publication_date` text,
	`accessed_at` text NOT NULL,
	`geographic_scope` text NOT NULL,
	`verification_status` text NOT NULL,
	`reviewer` text,
	`verified_at` text,
	`limitations` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `users` (
	`id` text PRIMARY KEY NOT NULL,
	`authenticated_user_id` text NOT NULL,
	`email` text,
	`team_id` text NOT NULL,
	`role` text NOT NULL,
	`course_section` text NOT NULL,
	`rules_agreed_at` text NOT NULL,
	`registered_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `users_authenticated_user_id_unique` ON `users` (`authenticated_user_id`);