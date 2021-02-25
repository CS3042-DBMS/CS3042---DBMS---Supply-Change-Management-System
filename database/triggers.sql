DELIMITER
$$
CREATE TRIGGER `a_r_update_trigger` AFTER INSERT ON `driver_assistant`
FOR EACH ROW BEGIN
IF NOT EXISTS (SELECT assistant_id FROM assistant_rosters WHERE assistant_id = NEW.assistant_id) THEN
INSERT INTO `cs3042-dbms`.`assistant_rosters`
(`assistant_id`,
`schedule_id`,
`worked_hours`,
`consecutive_schedules`,
`working_hours`)
VALUES
( NEW.assistant_id ,
NULL,
0,
0,
0);
END IF;
END
$$

DELIMITER
$$
CREATE TRIGGER `x_r_update_trigger` AFTER INSERT ON `driver`
FOR EACH ROW BEGIN
IF NOT EXISTS (SELECT driver_id FROM driver_rosters WHERE driver_id = NEW.driver_id) THEN
INSERT INTO `cs3042-dbms`.`driver_rosters`
(`driver_id`,
`schedule_id`,
`worked_hours`,
`working_hours`)
VALUES (NEW.driver_id,null,0,0); END IF;
END
$$
